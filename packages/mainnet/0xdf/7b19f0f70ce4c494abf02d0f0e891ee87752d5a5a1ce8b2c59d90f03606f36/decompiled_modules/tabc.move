module 0xdf7b19f0f70ce4c494abf02d0f0e891ee87752d5a5a1ce8b2c59d90f03606f36::tabc {
    struct TABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TABC>(arg0, 6, b"TABC", b"Test", b"Test ABc", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRr4DAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERHCQNo2hfn3dGdRcYjof9QBsPr3AFZQOCB+AwAAMBUAnQEqgACAAD5tMJRIpCKhoSaRStCADYlpANX8NG25/JQDXPJnfRGDUf7SEuCu68FMN1MPAbhWVojB76kSsGNtuO+iIOva9rlleQYXT95KS5O7ZQKtIuKFnUQPvsr64peTWH9NFyCyed4aIyPRFzXMbfa0lw+0CQy2xry7+zXmvTLDnwh8XsMR6xqifiPc9bjOaxm3BfMZJb2oocY/ol8Nk9KcsoTNFlovVxnriQQBoAD+/Pjy/4kP+Knis4CG8sebv/l23SUtI2QczGGYMxTHTUXTZk4XOhwayghxzIeuocMZAfSGU1CPCAty1bqUk+37Fq70I2ec5eA7rqZ43hgYtEErzuVMcmqfKRsf4DutnHJSaMIexFfvxmLXa7pwUi8EgTDNxFZ9JTdjRlNpM4way03CT7tmERwHAXPnxYkDCQdFXiCJDEJPxjH85PUm74X3QMSafdkwvVr0mKYSa1ktUjap2luoEdFGktyUDSTj3U/nufwP8tVUqa2LgWmEIDeQhTAv/ev4XnvYYSSRQ9RKxb2JiNQXnPDaRCHQLEu3b/R62AqDeXn/m8H8eBlpTpRgkwapCO0kpb9iU4t2uLj/0pCK7/TUxitHol+2lzmDTdAXwvDfHSeYJSjPdtuPkecAxVRBoseKgTop3Xox781J7oUhKQ8OzWvm03Kn0w8J46N3dUFhvNXwed9angQr9OujbM9VQR/veNA4NMgcXKOfD3HemMpFqyZD20ykSiTIi154gGzv8OJzzYF9zdJvkV08GHWCtY1L8Dc9RoPvda/fvSX5DfFWleT6LJvDsU5dJhif61dYICyJt5awweG5Xnt6jg5Oi5gw9lip3b319n4zv8emsQp44RAX1gUTHJgqzuRA6f4fJcVXwbFlM56FPqCDB08rE0XFSr8IbwjSS6eN5qbzfQZ6Jk2/8oonfnVvPzowRbEWfqEuu1U3NcTgf5ugFTGeyz4p3H2+3K2K874gU69hGQEAOsGgr2DL94kylFJZAmFqoA/X/suqxLizkWAyt74xwy3O/HaKbYF8lqpvf0gb+KKXyGufwnztsLUe/K+VCinY026Z4MgJoM8SAyG1oTE58Jus+J/ziwlz5dA9Vca+/TrJy44EIBLhrdclb3ttD65aQ9X0RVAVjzb9INAEZpb89+gtVUcuARjq07D3ZRlB/17kzOJ6gAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

