module 0x8af6f84a825d50755ab94ac5f706f50b3590a423f382a6568b4d785abb4c7d61::bocat {
    struct BOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOCAT>(arg0, 6, b"BOCAT", b"Book of Cats ", b"Book of Cats is a unique token for cat lovers, featuring a collection of cats securely stored on our site.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730966100855.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

