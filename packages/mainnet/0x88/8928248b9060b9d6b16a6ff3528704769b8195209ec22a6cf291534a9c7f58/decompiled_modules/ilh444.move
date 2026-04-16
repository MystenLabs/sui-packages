module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::ilh444 {
    struct ILH444 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ILH444>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ILH444>>(0x2::coin::mint<ILH444>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ILH444, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILH444>(arg0, 9, b"ILH444", b"ILLUMIHEART", x"496c6c756d69686561727420746f6b656e20e28094204669626f6e6163636920737570706c793a203631302e20496e737572616e63653a203130306270732e2058616861753a20724e51697a3536334465556a54665a4d4d4b517935325938527461746558714d6852", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/ilh444.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILH444>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILH444>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

