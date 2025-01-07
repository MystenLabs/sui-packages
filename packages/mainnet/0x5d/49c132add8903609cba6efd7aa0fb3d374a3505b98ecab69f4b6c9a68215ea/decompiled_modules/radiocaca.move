module 0x5d49c132add8903609cba6efd7aa0fb3d374a3505b98ecab69f4b6c9a68215ea::radiocaca {
    struct RADIOCACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADIOCACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADIOCACA>(arg0, 9, b"RADIOCACA", b"Raca", b"GameFi, Metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d07b832-b2a2-4ffd-bb2f-5e7ed8e6d75c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADIOCACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RADIOCACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

