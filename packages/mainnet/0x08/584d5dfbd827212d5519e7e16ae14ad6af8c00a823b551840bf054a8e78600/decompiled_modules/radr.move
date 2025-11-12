module 0x8584d5dfbd827212d5519e7e16ae14ad6af8c00a823b551840bf054a8e78600::radr {
    struct RADR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADR>(arg0, 9, b"RADR", b"RADR", b"Decentralized coin mixers (privacy protocols) leverage smart contracts or decentralized networks to enhance the privacy of blockchain transactions. Their advantages are significant: funds are managed by code, avoiding the risks associated with centralized platforms; with no central servers storing data and transactions being encrypted for processing, the likelihood of theft and tracking is reduced; they are highly resistant to censorship, as there are no control points in the network, making it difficult to block them; the code of smart contracts is publicly available, allowing their logic to be audited; they employ cryptographic techniques to resist collusion; additionally, as open-source protocols, they can be easily integrated into wallets or decentralized applications (DApps), facilitating the sharing of privacy features.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/hpYEbynFJxrt-WqeasTBnGVIuR3M3vrzXQM4s8pcIWw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RADR>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADR>>(v2, @0x50ade98fd20d7cbd20664b116822cabd180203ad68bb80cad3405b1ea098df39);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RADR>>(v1);
    }

    // decompiled from Move bytecode v6
}

