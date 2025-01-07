module 0x4d57d977f0b0d0d4d3d444784e9647333e4adf6db2ffce82af1e3b41f559faad::blsf {
    struct BLSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLSF>(arg0, 6, b"BLSF", b"Black Slerf", x"54686520636f6f6c65737420536c65726620696e20746865206a756e676c652120f09fa6a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfXCERUrB1A85BeFCHuAV19DZ4XkGdL4HFgud6ZZ23xzX?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLSF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLSF>>(v2, @0xae7aa3c50c2b94b6d6740fc67d00cce9530417b77ead1659ab0782300647af6d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

