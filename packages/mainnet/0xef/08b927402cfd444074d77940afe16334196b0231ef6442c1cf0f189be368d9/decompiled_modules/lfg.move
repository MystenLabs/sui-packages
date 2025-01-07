module 0xef08b927402cfd444074d77940afe16334196b0231ef6442c1cf0f189be368d9::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LFG>, arg1: 0x2::coin::Coin<LFG>) {
        0x2::coin::burn<LFG>(arg0, arg1);
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"Let's Fucking Go", b"Let's Fucking Go to the moon and build strong community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LFG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LFG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

