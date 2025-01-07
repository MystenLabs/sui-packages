module 0x23d639f1ddaedd36fabff779835d2c117c67c0c46465574249192f4a9e390170::supra {
    struct SUPRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: 0x2::coin::Coin<SUPRA>) {
        0x2::coin::burn<SUPRA>(arg0, arg1);
    }

    fun init(arg0: SUPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPRA>(arg0, 9, b"cute zxc", b"ZXC", b"abcd zxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Zh8mb4W/download.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRA>>(v1);
        0x2::coin::mint_and_transfer<SUPRA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

