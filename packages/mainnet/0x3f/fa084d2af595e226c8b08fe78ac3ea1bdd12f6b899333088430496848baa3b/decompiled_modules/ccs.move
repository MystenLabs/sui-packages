module 0x3ffa084d2af595e226c8b08fe78ac3ea1bdd12f6b899333088430496848baa3b::ccs {
    struct CCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCS>(arg0, 9, b"CCS", b"CrazyCatS", b"For all moments my cat crazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bdb9d35-bb03-4cf3-bcd6-dd1536f5f6d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

