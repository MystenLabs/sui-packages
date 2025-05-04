module 0x9805d6fc4e917165f844f505b473783c2c2907206979affb1c064409a295f766::wigglo {
    struct WIGGLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLO>(arg0, 9, b"WIGGL", b"Wigglo", x"576967676c6f206e65766572207374616e6473207374696c6ce280946f722073746f707320766962696e672e204120776967676c65206120646179206b6565707320746865206265617273206177617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeialol7tmxbwt4bn3o6vjywh2lkenlos6uz6ymsbg5nv6bunouxvqm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIGGLO>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

