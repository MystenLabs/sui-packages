module 0x38924007c43d8537c737a1b43026bfed113a0c68fbac287353257ce8763ce1ca::sigga {
    struct SIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGGA>(arg0, 6, b"Sigga", b"Seal Nigga", b"Thats not a seal thats a sigga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sigga_baa36a655d.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

