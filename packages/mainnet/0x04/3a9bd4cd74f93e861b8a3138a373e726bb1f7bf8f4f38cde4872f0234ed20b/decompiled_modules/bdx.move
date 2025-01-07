module 0x43a9bd4cd74f93e861b8a3138a373e726bb1f7bf8f4f38cde4872f0234ed20b::bdx {
    struct BDX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BDX>, arg1: 0x2::coin::Coin<BDX>) {
        0x2::coin::burn<BDX>(arg0, arg1);
    }

    fun init(arg0: BDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDX>(arg0, 6, b"BDX", b"BDX", b"being dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.beingdex.com/logo/bdx.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BDX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BDX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

