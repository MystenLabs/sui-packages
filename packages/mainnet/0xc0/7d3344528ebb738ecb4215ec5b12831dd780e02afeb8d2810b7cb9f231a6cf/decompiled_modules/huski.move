module 0xc07d3344528ebb738ecb4215ec5b12831dd780e02afeb8d2810b7cb9f231a6cf::huski {
    struct HUSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSKI>(arg0, 6, b"HUSKI", b"Huski Token", b"Huski Token (HUSKI) is a unique and community-driven memecoin that revolves around the adorable and beloved image of husky dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfLdpjGTATYzRHUDUxzR4gpMeaUanxFxkrDoBbf2TGikd?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUSKI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSKI>>(v2, @0x30fba4730ab2647539644fff946392ef9d341616c38648815d5c8e0fc30ef7c5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

