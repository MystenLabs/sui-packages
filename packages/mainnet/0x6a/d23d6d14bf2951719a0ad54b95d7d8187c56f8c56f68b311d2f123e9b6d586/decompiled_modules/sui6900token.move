module 0x6ad23d6d14bf2951719a0ad54b95d7d8187c56f8c56f68b311d2f123e9b6d586::sui6900token {
    struct SUI6900TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900TOKEN>(arg0, 6, b"SUI6900Token", b"SUI6900", b"join the wave of prosperity on the Sui Chain, experience unprecedented wealth opportunities, and seize the key to your financial success as the tokens value soars.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_12_23_05_49_2f5cae7fe1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

