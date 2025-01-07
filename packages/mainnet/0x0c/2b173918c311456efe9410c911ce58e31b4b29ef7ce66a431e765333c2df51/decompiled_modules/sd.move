module 0xc2b173918c311456efe9410c911ce58e31b4b29ef7ce66a431e765333c2df51::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 9, b"SD", b"SDF", b"VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2e9ac29-6d7a-4511-96b4-a167017d682b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

