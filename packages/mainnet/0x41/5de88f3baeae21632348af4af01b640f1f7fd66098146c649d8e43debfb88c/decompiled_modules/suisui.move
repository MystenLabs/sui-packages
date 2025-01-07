module 0x415de88f3baeae21632348af4af01b640f1f7fd66098146c649d8e43debfb88c::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"Suisui", b"SUI SUI", b"SuiSui Token | Play-to-Earn bird racing on Sui blockchain. Compete, earn tokens & shape the future with our DAO. Join the flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2347_a3714d8f2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

