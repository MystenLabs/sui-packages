module 0xa3770eb34c7d6abfc553a50509975fb6e54c6e3e7f268113756a68dba6077bfa::bumblebags {
    struct BUMBLEBAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBLEBAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBLEBAGS>(arg0, 9, b"BUMBL", b"Bumblebags", b"Stumbling into gains never looked so cute. Bumblebags buzzes around, clueless but always with a bag full of luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid2mevt6oba4aavutlmflmv353oum5htmiotthxovggdhfrtrqmby")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUMBLEBAGS>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBLEBAGS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMBLEBAGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

