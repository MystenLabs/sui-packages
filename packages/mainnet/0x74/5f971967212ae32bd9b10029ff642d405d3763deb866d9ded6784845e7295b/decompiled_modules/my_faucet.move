module 0x745f971967212ae32bd9b10029ff642d405d3763deb866d9ded6784845e7295b::my_faucet {
    struct MY_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FAUCET>(arg0, 6, b"GFF", b"Gayfish_FAUCET", b"my_faucet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.z.wiki/autoupload/20240810/FHGG/993X866/gayfish.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_FAUCET>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<MY_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_FAUCET>>(0x2::coin::mint<MY_FAUCET>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

