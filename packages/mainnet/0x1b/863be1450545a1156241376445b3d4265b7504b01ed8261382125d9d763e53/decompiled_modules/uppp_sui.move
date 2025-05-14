module 0x1b863be1450545a1156241376445b3d4265b7504b01ed8261382125d9d763e53::uppp_sui {
    struct UPPP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPPP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPPP_SUI>(arg0, 9, b"upppSUI", b"Uppp Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlAFAABXRUJQVlA4IEQFAADQHACdASqAAIAAPm0ylUekIyIhKRVZYIANiUAaS62He/v5q6+zmaAP0A3A/7Y9Tb0Cf7d/wOsA9ADy4PY4/br9tPZueUL9Vw97Tv+Qgj+UMzuPUvsD9KL0VSxlF//BcesSPBK/WtTC9kZJpPTeWusDhcNAsstnMs7xfWwz3rFguW/1pUplz5n98rPO/njohsTQLyd14XuNZ/sX4oMUYMRNfH4YLC/Ir6s26Z+++kYeR68ev//tVydBhern4Wdz24g/Ojlva9qlOx1pJ4HL2XVWIglCf5iKGnfl7BUdVMIxCQ7SI1mGsXp+hwUs/C8O4AD+/PhMymNj+QkYtp4cIUKrKbm2PzBJbglX4CT/6Q/3roajz0YnJmc9wXHKl50wrdoa31B96aUpHrhbvwfkuZ4MFGAiovjlflDy/SUepcgUXMj9zR62h9l1h0T2cfewAJ6RheO/RfJXlP3XFVXxyUc4WBEhmo3QLGZZ+4ub4v+JwLOUGa4B0x+S4+IOKbKtlkbvG14bnv9HzmZALLmOPFceT4dt16diqtdRORc1dGn+LywPsBul8W28LDAMpxsgWt7+r06BiL4o/7l4QkuQFHjNYdMHINgotWZ9c6xAkUshmf4jkXcSeIro0LqTGjOBS/kayxcJA41YUHrzYe8L1sZ12/sJMOkMmZZfjye8Z8ZISqTEXuv1Iu5PT5WfBg5SRWmagB6QJmsv8q/f702Fm+IIEwmKZSrYoq861aA/mJ+P2K+JvAAL0rIn+9Jma6+kkj/bmt84QlKV65dz2+Ui+eEW2p8Hf7pahYb9uOrrx5YcGmrchmmC1zlUorvxTN/B/X8+/dAc4dM4Lq5lY456f1GUT81JbCrAnIbESsBc4IRpI26BJ0+tSKMXnd8nJXN7hi/E/MAkeDMIDODsfoJdpY+baaR/2kbSKdAcWXQhdqNlHuht14yYw2lm3g7gi6bRr0S8vvGiecGZpwsgKbes0WQfecEnND2MMbx2yi3BuKnTXf7PxeRSaLydZoxlX3IGtA4Q6zxhbPpg6UeMLdpHTO29nzFS+yAFlO1MUitwO7fbnBKjWnxUrK7qpSy2muuFZTSbOl/p8USAlFm6uEOjLFPYj0p1S9wT+pW6LJXvJkkaMocAYz98os5Pfv9qhs8udd3wlO+WlDBpTtOnxYBt/DqdyWcmgoLa3GLezwwOL7rh4n602r1XbVe5dMRNaK42VqRAjK7l8Iv72SV2BuNK0UJ9BUEvGSLJrXJAhID5bqKXlxyi3AIfu6P5xTiDBnCTf66GF1SdUW1/VC3ghmhsWRv5kQvqhya8n+uAggzuYV8nJzs0oME8FfCc5wME4fr/OECRIHZ7N8YDq+hvZCAzf+a/CxybCS17CGn4i2rCDS8TnqwqoGW+tz5bCV3u875NA/hkn2A9U+/+wrUab+oEHmTVls1dCAZ0XrbqzeLmSKJQxuzeIn/B/bb5SezFAza0uOggY/92XzkZ/g/8xNm9j0JTgZTL8c+Yl2MV+UL3/ChnOt21/q2+MfQBgzwR2hd1DB9O/iB2hGFPAivga5y+rh78RoeFKVZT1GgJXvY0DWnS0OF9rG8+OB5bMoUGh0pNhK1a0mNk3CPXoZeV3VdcWsD50qjnUJKO4S1nYcPcw7PL0PkdKSb3UIkFqfsNQgf3Z6dFP99wxjv10qjS12s4IPPkKF7C4xXCzvtbWbQT18ipQNR5lbic7JbpmN1I4sDOakOhSBCNjrGUw/xxLmllhKuKJYg8gVe4DS0BHHTjTW++2vNhwwQsYvPKLWOWSjV1B/t7AAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPPP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPPP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

