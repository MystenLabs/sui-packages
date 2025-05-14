module 0x95f9099dc0fc8edbd8239421269a41f0614e82621a0382eaabbb3e0896496433::spiece {
    struct SPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIECE>(arg0, 6, b"SPIECE", b"Sui Piece", b"Ahoy degens! The worst generation has made it onto the SUI network and are ready to conquer all other memes! Join the crew now and the quest to find the SUI PIECE!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeietcg4o44xdnawlfci33yukvhnvteu7xj53syyjcnljuj7um5or5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPIECE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

