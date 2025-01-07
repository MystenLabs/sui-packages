module 0x9acfe50ac3f9a432a6c35605c19bead46e769d688b3a5a8a6f7888fa0197a11a::mkfa {
    struct MKFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKFA>(arg0, 6, b"MKFA", b"MakeKamalaFuckedAgain", x"4174206576657279205472756d702072616c6c792c20737570706f72746572732077696c6c207361793a20224d4b46412220200a4d414b45204b414d414c41204655434b454420414741494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056593_285ab8fb20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

