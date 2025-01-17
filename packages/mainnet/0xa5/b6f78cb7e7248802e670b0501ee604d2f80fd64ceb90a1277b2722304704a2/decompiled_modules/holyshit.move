module 0xa5b6f78cb7e7248802e670b0501ee604d2f80fd64ceb90a1277b2722304704a2::holyshit {
    struct HOLYSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYSHIT>(arg0, 9, b"HOLYSHIT", b"Holyshark", b"there's a growing pile of evidence: holy shit may be the purest expression of hyperstition", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fce4057b-c089-4fcf-8475-7a2d98a25634.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

