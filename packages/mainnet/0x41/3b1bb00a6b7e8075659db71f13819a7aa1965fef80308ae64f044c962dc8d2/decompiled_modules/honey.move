module 0x413b1bb00a6b7e8075659db71f13819a7aa1965fef80308ae64f044c962dc8d2::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<HONEY>(arg0, 6, b"HONEY", b"Honey", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgoEAABXRUJQVlA4IP4DAADQEwCdASpAAEAAPm0qkUWkIqGZ+NaoQAbEtQBOnKCqnw8+9/jH7Kll6/UeyGJuAOeG6IDqcPQA6VCfZc8ocVTI9V8z4c6exp4egxg1/a8t/kZ/4HqyqzF24vMngT+ytGWJKzlFz6yN5w4MRqU97SeW/RNTqR5nPaHtM+GkoFpBv/lLD+fVQkwas/8/K/yASzr1cCIS9vCgAldrf6xbyQ3yLIOnWVBKAAD+nw+0OrjUU2socR54oVesfKCjb/cPnQ953U8IJ7l2AbzmMRmMe/zK99nbqxh8mURG/k+JZmhGJLAp/+4g0dNpnXy8eekg6cdDkCqseX15+Ivcs8BV/19nxEh97CEDI4CUyC+7u7vdq0aasGwdkWzS83uE4MonzTQhQuaW1c4pe0T2FtdayaVJvTkMRZybkzt3GXGHbB1idDsFVUR/LoSXcUnxl1vzED0iChvqYfvY4pNSSChH8QhGHYQjgkZm+5cOokRI4rRSWf/fQqzn9xjTydAhP+WnR5lHqjc1y/iz9lVTaGn6xhUW9Pk50tBbR27zA3CS+WwKNNFqb5KSpGgEalRUZiEelqESYYQ+Vi7n85awmp4bYjLmrf9HCv+Jr4w567nkwngSOneXPWLvSbcdYlC/FTa0XLtw8mKDCJbh+UsQivopBjmCzyKOn6V074O4Ob+ZYloVBkWOu05vcvR1QwKmVYpEVumTQzI+WrOVSoOQME28XiRpFRrwpwVaREIyao8sg6ejLtfj4w03oP7t6dxXhhi+OcAYYk+FeEx720lqQ9kSptbblVx6AYuI5SGCI249rAOdgr87/NUuqmMkcvvPx9iaU5jhQ8/r/ogZVoeINmRD+rX2dnORRbKOiPb2cNBO4rva4QOTI/nOVRuFHB5lKvef6Y3zcLAGQE4sWt1792c/YhJgYbbrN7YM6AWdrc8xOiLp2plDo8GwRnn+HVes+2IddYPF40xhskEicbUHr0Yd6iXstMEjIw+q8DFmNsGfe/2FgZ329jKMB/RILM4htN/rH2+5KcUijRSF5raZ8Yy7RYIdp/AZ9usrQO5rze9gOK0nyQEvaxNt8I0LUVEwlt8jsyidwjRKZ2JLlo1YOYdANZHlW950+OiySm9+VfjjxP/3iP99UiPh3HEx1IUvp85lvqDypFFly7pg1N6uUkvcARsPAMmTS3iOrhYpyhNQzX23H10HCpnKoRtCMaf9WOagRB5YDXU9I7GNdIbfKEONTfN2IoMtGvnQjqraQ1luqJum0MZIfjB52oz7ELfSUs5sVT9At1Ysx4R0Oz2l4XvhQTnjiNoe+3irBliMsskyWNzr6BO16KX40wODsKBANmenauNIRIdznX2Tb58vaAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

