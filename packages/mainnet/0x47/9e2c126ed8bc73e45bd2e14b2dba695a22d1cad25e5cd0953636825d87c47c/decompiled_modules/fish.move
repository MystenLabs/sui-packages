module 0x479e2c126ed8bc73e45bd2e14b2dba695a22d1cad25e5cd0953636825d87c47c::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FISH>, arg1: 0x2::coin::Coin<FISH>) {
        0x2::coin::burn<FISH>(arg0, arg1);
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"FISH", b"FISH is the native token of FISH.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreia2vfy4zap6plymncr37eeywxbno6zzfcchnrvrlys3rgbimx5w5a.ipfs.nftstorage.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FISH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

