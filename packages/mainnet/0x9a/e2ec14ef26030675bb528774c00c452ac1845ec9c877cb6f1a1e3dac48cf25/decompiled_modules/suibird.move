module 0x9ae2ec14ef26030675bb528774c00c452ac1845ec9c877cb6f1a1e3dac48cf25::suibird {
    struct SUIBIRD has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SuiBird", b"Let's Fly together!", b"https://t.me/sui_bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/87sP9nG/Untitled.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIBIRD>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBIRD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBIRD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

