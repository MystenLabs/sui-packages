module 0x38ff231442cc62d03f200d3d60bac64babd3303cc58537d02f3f03f52ecd831f::suiclips {
    struct SUICLIPS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICLIPS>, arg1: 0x2::coin::Coin<SUICLIPS>) {
        0x2::coin::burn<SUICLIPS>(arg0, arg1);
    }

    fun init(arg0: SUICLIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICLIPS>(arg0, 2, b"SuiClips", b"Sui Clips", b"Sui Clips on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.clipstoken.xyz/_next/static/media/clips-logo.51a6523b.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICLIPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICLIPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICLIPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICLIPS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

