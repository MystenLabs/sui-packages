module 0xc6eae9032b8b46d9051ad9e86ea29c42bcbb749c21e6da7e443bb93ab140c04c::token22 {
    struct TOKEN22 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN22>, arg1: 0x2::coin::Coin<TOKEN22>) {
        0x2::coin::burn<TOKEN22>(arg0, arg1);
    }

    fun init(arg0: TOKEN22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN22>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN22>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN22>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN22>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN22>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

