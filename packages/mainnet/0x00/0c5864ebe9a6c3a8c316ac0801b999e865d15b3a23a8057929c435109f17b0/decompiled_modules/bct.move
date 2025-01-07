module 0xc5864ebe9a6c3a8c316ac0801b999e865d15b3a23a8057929c435109f17b0::bct {
    struct BCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCT>(arg0, 6, b"BCT", b"Bitcoin Community Token", b"Memecoin version of bitcoin. For those who missed out on the early days of bitcoin at $1, here is a version for the memecoin community.Aims to be a community coin for the people: the sky is the limit. Created by an anonymous developer from the Boomer generation named MR BT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000040_b54c4e5ec2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

