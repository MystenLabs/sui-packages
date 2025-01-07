module 0xeb530467d95e085a31b61080ebf07dd201320775b52682a1de37027af26035f0::suildier {
    struct SUILDIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILDIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILDIER>(arg0, 6, b"Suildier", b"SUILDIER", b"The crypto trenches are no place for the weak, but for Suildier, its just another day in the degen war zone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_233746_732_24f04b5679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILDIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILDIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

