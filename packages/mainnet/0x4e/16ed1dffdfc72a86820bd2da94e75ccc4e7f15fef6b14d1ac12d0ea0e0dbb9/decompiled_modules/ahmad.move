module 0x4e16ed1dffdfc72a86820bd2da94e75ccc4e7f15fef6b14d1ac12d0ea0e0dbb9::ahmad {
    struct AHMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHMAD>(arg0, 9, b"AHMAD", b"Afaq", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80b1085c-d2b8-4dbe-bc07-b635cc4ee04c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

