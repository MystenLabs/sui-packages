module 0x95585366c2295ec0b0b05274ec2a4428709218feddb441965887cdc96aa7c60b::nns {
    struct NNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNS>(arg0, 6, b"NNS", b"Nong Nao Sui", b"Old cute doll who will be your new friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul67_20250103204155_cd1db7fd9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

