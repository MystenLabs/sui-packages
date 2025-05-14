module 0xe98dd7d743931b6108a29ce08c119af448752fa1b2203d2dad39bf47903d3481::sha {
    struct SHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA>(arg0, 6, b"SHA", b"Shasha on Sui", b"Shasha on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHA>>(v1);
        0x2::coin::mint_and_transfer<SHA>(&mut v2, 1000000000000000, @0x6a171bf7703a1c01ae5f7f6c279138012a2dd43859a8d10941d229bdc92cb8a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

