module 0x189e7ba7e7642d38920560b8b4ac86b7d6633ee30df30f30b87f5a1df7f02ea0::ftb {
    struct FTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTB>(arg0, 9, b"FTB", b"Fatboy", b"The fat boy who wants to be in SUI. He's happy and needs pumps, can you help him?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cb416b6-40d3-44d2-8006-f6b3a9534573.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

