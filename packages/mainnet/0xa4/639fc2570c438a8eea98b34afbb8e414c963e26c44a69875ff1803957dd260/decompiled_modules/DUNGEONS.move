module 0xa4639fc2570c438a8eea98b34afbb8e414c963e26c44a69875ff1803957dd260::DUNGEONS {
    struct DUNGEONS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUNGEONS>, arg1: 0x2::coin::Coin<DUNGEONS>) {
        0x2::coin::burn<DUNGEONS>(arg0, arg1);
    }

    fun init(arg0: DUNGEONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUNGEONS>(arg0, 9, b"DUNGEONS", b"DUNGEONS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/qJkpyWc/dungeons.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUNGEONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNGEONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUNGEONS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUNGEONS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

