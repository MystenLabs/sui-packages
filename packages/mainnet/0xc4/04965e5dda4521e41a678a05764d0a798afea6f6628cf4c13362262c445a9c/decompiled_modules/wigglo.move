module 0xc404965e5dda4521e41a678a05764d0a798afea6f6628cf4c13362262c445a9c::wigglo {
    struct WIGGLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLO>(arg0, 9, b"WIGGL", b"Wigglo", x"576967676c6f206e65766572207374616e6473207374696c6ce280946f722073746f707320766962696e672e204120776967676c65206120646179206b6565707320746865206265617273206177617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeialol7tmxbwt4bn3o6vjywh2lkenlos6uz6ymsbg5nv6bunouxvqm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIGGLO>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

