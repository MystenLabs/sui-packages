module 0xcf24810676076b5db258c7ec94ea9c5a8dc5b31a8c7b17a466d980ff87d36fc0::ttt_sui {
    struct TTT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT_SUI>(arg0, 9, b"tttSUI", b"TTT Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRv4CAABXRUJQVlA4IPICAACwFgCdASqAAIAAPm02lEakI6IhLJmYOIANiUAatq9/2nVhe7fjdyonGngv15ZfHzAe6//HewD8bewB+gH9J3QH7Gfqb7un8r/zPsA9AD+k/wD0mfYb9Av+Aed3+t/wwfsh6Suq59AJmb+EoU+DUAunLTaqI3wf57BVG4xdWuFUuvy0AHwgFrB4Oix3DmsbuX7gfd8C4+iZiurI4rBxkw9/WWUd57kvpnBNlf9vuztt/Gkq95MPHLmhygq+NSTAAP7syCv4VQQzcP30A70A70AxWpwK3wAVeJBTM+uH6Cbh3QG2P0vwU939+M09gnGaRJa/xcK0P7846tRfn8IK9OfKWZj8P18B0ktQzH+X/+7fkhJ7lIc59AyJDWka3UAEeAEDT4qzKGlecA42tk8AZDkVyAfpEsDyQEFjNHc3MJVFh6fLZkMESopFS9gXD0dqoWSYkoRve3Y9LDB8Oo20R9vY2haUgf83/1IZfgy91q1vIRYXguJ7Ri4RxL4deb6lr4mjRLP5mQGxWTt8esOitCg18InqbZadUgsKptWigYh6gXmBSS+5Sf5QxTSOXphE11dxxWwxEEHPJeAOcFa99duj/n2Tg3rze6nDxlHgTv3PIP/wA9ilcd7Lf+RsbLUyWS+nf9XMOMc7KdBzpFpBKs28FfwF4bRC18G9e3+/wb9ZPxGia+13KKximWFhMAX5uiLWKAxklagmY2qdWOOCD901n7+qwv15AAJkwAd+V+1syTY2jB/9lhS7flqt694Cr+UFDWU5FPGhih2Jr+ouPi47YUmjSlsPt/xmvcDt7zjrCY1dwVmBH5EGQKE3CK9BY40qXCFt1te6EXL/Wmkrcf23xnFDcrF4qdcoJ9TK4hO0cs2g4bcCQYEJWf9aJUjzoT/MXeM5k/wfrGHPJ6CNVkT/z/dHKwgOuiFusMf8edW/nN2lvTz9c2gyL4VVlPMJFTVf8gHRYLRdAzr2wVeEmw90ZSRl51Z8BA5eIidgAAAAAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

