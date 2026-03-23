module 0xff72a6cc1cc4746cfb7f3b559b04b4382fc1413d76cd3c3533a785d4a811e465::xag {
    struct XAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<XAG>(arg0, 6, b"XAG", b"Gold", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRioDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERFCTEPoX1oBry2i/0nOnZIHVlA4IO4CAACwEQCdASqAAIAAPm02mUkkIqKhIpM4aIANiWdu4XSTyM/1AywDeJPJmu5irq93x8dlAzweAHcJcYSXxzlfR/7EfAd0gE70re/lebpIx4jSRWXn2Ei7OC6h+i1TnneVYllj8TN78gb1tsTqNaubPUydGrDAWd36gCB9f4Tyq+DxE5ZuCeKcg7uMJ60aYaJaVvfyvN0kYoAA/v+1kAaQDySv/weUqCW4qKyTiky1AO4gWxU/jcYAWDer5IclF6SpJ5hPTehgqR6my+oxRn/e72UJCu44hRy8AT+vgrC+7GOtqoqmVH1uj6UwRNEadX2h2GOUuvmESLdL7beGAO++EgP9yzwrajx3uR/HpcDCsk9wrex5ACtYitmWuYfLAxXWRr/agnJlHBA6nc38/JZaCGoAI0NOFHBFAE75Hs/zN4/ZO+zedG269NM4XLH/cQsZL0pMU9Cjer48Hq62kPDndn689+DvNR21PFr6XEHO8kHvbb8pF9TK7ST27yS3DgxMkg1mnZ1u59O0SMJv6tL6pXV9Y/dT35+mTgPq7o2z3DdxzTHhGvC6geIrxf/w/J+18d4N/MUlqc//n8AK78zmhzIelJVR/dee7SGDMt+E/c+qSnZUGYmXkwCQ/P5Ws/8X8ja2/tnpBg89Rf9HkxjByIWL5j1pQwPJKUyBmBu/LT+rL5Btl2uODRxQ6I0EUBIb6yPt24tkzsfmw/eg3lD0GHO9shCbkati/t/fBREIMkn7/rPfJxf9L6Zsd7iJxhED/w/ChXryBr9ejaDC3bA/Ts5Vi/X3/9Moa0LZsghHUY37KhMK/jyex/4jId8M/pHiinZusc/3hhw3NFt4um0E9S24J8u98e0iChGK7GIP6Zf3nkSVMyX8KTIaHslkuEt5031mdsYlFG+/60OTI2yyG6EWB+4cHi2XyH/FhMP/4Cu7Y3ogrQDnc6Fmas994kJcckcc52yvBIJ7eiB/VSY2zCC0enE+ycvyoqsKEfgAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

