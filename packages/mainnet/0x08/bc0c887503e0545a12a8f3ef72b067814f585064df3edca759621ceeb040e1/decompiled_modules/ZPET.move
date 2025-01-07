module 0x8bc0c887503e0545a12a8f3ef72b067814f585064df3edca759621ceeb040e1::ZPET {
    struct ZPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZPET>(arg0, 9, b"sZpet", b"sZpet", b"Claim #airdrop, Raise Zpet #NFT on #sui and earn $sZpet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746758400594321408/bHUmmi04_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZPET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZPET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZPET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZPET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

