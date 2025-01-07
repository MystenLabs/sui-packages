module 0x52ff5d0f1697b61a35be246973aa5a6b4880b5428d0bbdb504308747b5b4e17c::molon {
    struct MOLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLON>(arg0, 6, b"molon", b"molon", b"mo!mo!mo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSmGcdk2N5EpfZjvzhev5Jiw6y2C7dkXx3U6gebbU2MCk?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLON>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLON>>(v2, @0x3e5bf2beee17f430e084520847a8684e704d98bd0c3c3ed10356bb498a064b4b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

