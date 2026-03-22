module 0x22ec84fa867a9cf34b9eacf883b8956fbe2927d1931a669d77d73d4beee3a230::ox {
    struct OX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<OX>(arg0, 6, b"OX", b"0x", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgoFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERFCTEPoX1oEly2i/0meuyAXVlA4IM4EAAAwGACdASqAAIAAPm0uk0ckIiGhKZQ8mIANiWkA1hV+dmmvB/0XR4ezfZ7lFM6YyqAk47VzI+fRXz6vV/Ak9E1Kp6osmS29x819ktggLB6Vv2WWseYChx5odXPfzLhdP29iItsfr4GCrgWuM67mCGYZWmgldDlwxbGYbTw6a4bYFkp08EIowCoJoRVrcTwRhjdyIhXW7M9ONhtl0VfZlzFp988InszyjslE3wGn0IZW0GPBr/7tzs/JV2BD44JsPVModw0HyN5Rw0QAAP0x///shoAAe+8d2g7/vuBxJgWnxbudKyqFfkKNasqOQjAQ0RX2OD+L/K/9LBHyJ7OxyPh4HM32tzTZ0yi2Sr0kSe/N/E9D+Z9BTBYiH2Ub/5kJ13fcfRVa6LiwOhvxxNhXnwunkMDh/7GS9+nndm3C1+Ze2ylLamANWEWxAHgM/Ihv291GOyoGQJ+RBhO/5UroPAydd3N+M/PGNVyB18dRDvh8dB1x80PaxhhDFOJrfSNMfIB5MfW/3y85WdKMb/V6py8GRspvi4oyZGvBOhtE3CJztblX1gP8BdXUs12IErDrnjhmkBPIcCn0/YTRHc03Z9oKtZRYH1uGWF0lTXNbDDAhZ3rqL1M4w+7cawIgg/ddYM29G3GI+LoXk2vD70wwP27daMG+6lRDOVP1qVTUn1V20SCSOR85sHhCzQLLSn4k05Kvv2On80YGSTjvQiE9rdDui3W0hhORybj/iyONeiGWDRwZhqfNg3KwPXIsVzVnnbO7yM/oFMCQo3JCiHMyfUmeMvMGeUEqvKIPtN+45fQORte/Ehzg9tBeEd3VZS5ciugrRSKGzPfAlWL9l7fdAOD3z2vfj0qJzO+Wfiqpmx8GIUfNY2vG6Kqujiv2hcUG3DHj3hQgWO6VNqjj2bzxO1yT/CmShpU2Chq0N86AobpPX+hDZvfjXoOSjZ/XChFSfNNp9I6HPw8EL0zQn1Rk+PLqSE7P0rU2277UTWm3l9ZaJ/gmbmc0cflboScpvVOxSX0/sNPV3PzUt9rQs4S5WINdbaOm6QjrNp8s0/jCZsIk3z/rSGGaKl7vKXg66CcLLXKOtAjiMO5Y6JB7krc5bpGOuzaPh5ohJ12ZEaghPg/XRJtqmdJAjVvYtaSftOLUr8GYw2qXpOWpMdUEO+5jDv8r9I9bR9yTb7axbDrDNY6lLfcf/W6LqDr/njpi22+/uDjhX01fv/43vu4IDUhhlHRWvANdqe5zMJj+cAdvuwV99Fbsncj5yKgSu2LCLB+7jCYsIWGPKvRk3JpK8fv/GEeRSHee4e5C7nsTbdOvvz5WkSjulu69RgSbVFaGJ2XiDduklI2Tbzjt8qD2oCmWLs8wgySqUPQLccxna7AtMuNZFCxNgP/HMjRLFjcMC+vzyPkAETcA3ismr6JWPN43bomF5KW8PPvW+/oc04Kyic6e8uZKZBcvjsbtP/j3LoQegu1vxwQ2hqrChsVQKNI//RU5WoVMQu+YCHjBX0uqS9JFzFB1QTrAVGEodeArn7jQIP+/Qqs4iI7WUCVH6aucGDW+bRSGLBr4m+FYMJiUpKFZ0g3Nl9Fd8h8WzfQ0X710fqW1E83uLrEE5gYS0rMAH8saemsVi9///sZ5hAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OX>>(v1);
    }

    // decompiled from Move bytecode v6
}

