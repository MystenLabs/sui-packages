module 0x112f7bc54ed6c1e5267dce453215537856702c8ad219682523df1575c4c9e374::abob {
    struct ABOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABOB>(arg0, 6, b"ABOB", b"aboba", b"what", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVnhCEqDZE34QZpv4BvmFujEFG6KWypNP898UKMxz5byj?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABOB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABOB>>(v2, @0x90bda91c34b77957d5896eb9d0508b075da44c21b7614c50151def5fce164b86);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

