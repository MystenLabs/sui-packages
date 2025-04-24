module 0xfec1b6d3860746bd1bb52b9d7805ae7d2f9c230763fc5af45b2fe8a7a7811845::p_sui {
    struct P_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: P_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P_SUI>(arg0, 9, b"pSUI", b"Poke Staked SUI", b"Infinitely liquid staking on Sui for Pokemon enjoyoors! Liquid Suicune Token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1cG3i4bfO5NuHxbHMuTo8ze5Z9vvzo-y5/view?usp=drive_link")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<P_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

