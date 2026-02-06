module 0x8e8de08cffcaac7d71a3c7b29293396086c9416e7fcf7e68eb2df8be25f9df7::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SOL>(arg0, 6, b"SOL", b"Wrapped SOL", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgIDAABXRUJQVlA4IPYCAACQEgCdASqAAIAAPm0wlEYkJSIhMBaIQKANiUAavjooAcq2WZhGfJbcfmA8/bTAN6hK8EM88fT4A7x0JJkO3zYSmsAeizTZ6mu2JlZaY0TMM/BMyQfuAlxrzt8jPgUsyBKsMBxezjpcANRUTPsaxCqbWRNieqmPyd2+gRx8vpEv9iMbamePvu0HiPpV9e1fzhaWw+DjR3TNkO4KNewAAP78+EAAKRXtMwy50KG4zyIFZgEFNtEKnuLeM/18HQCYIV0v5296YTmCaIGVaRfapyNJx90dxhX+f+JRv+HsywY1Esq+pWZDTVyTagEzxzN8gSefQN+iu2PZ5oyTkh1t4isurJ6TdMGe139YowX7EiBYeZRsUjxdR6xK932H7iDP5fgmyErmCNTMCaFGSTaQpu91XrxD8XYO03aly3j4kFLCjj9bIn1avik6f+AGiwmF4p7RsCtSpaauRulry2zZ7lO77nYuEyN/ezo7KYjsUf/vf9f+vg0REYh8urv9Xv4Y0PNcf0T8pcd/NTQ/NkQ9tSGdS5VFrW+zy55FcFY3NZ4EDg/J8/ZP9eEF2kf9bGwgjeCPJWQ4bObpiJ2hu2vsqKSqZHnxKmgwsHZGgmnxGSn52E5dvoUss4iAXncf1c5xhdGf81Ry3tVCLxfzKYN6vjRqX6AerIQfogNzuCP2k89b41Epif9YCUjvTTZMYRoWed9KvDLXG+yHDs2oEJ70kR/P+DB0btEKpUQ3+IwAAyhR+B/DWDkAcpDjGkhAewtmJkc2T20OzdNt9Q9VPdzVbul6n3kvzzgabg0u35GpiFQ8dvTvXy1PQ1kkag2BvUsjPm1GEptuuT6D/lxQUAHYPG30zQ3xTNAvMvtX1pJmCIS1VTM5eglwICzVAHlZkezl2wlEnNQ6k+Sxd2hF0eEBRGr8TG/ibVECNQFDcAWxxBS5iQo9wdFpKxlFyWIWiHSKMAMW47+MsNRdal6T4AunW/wz8qKllebA2j43Ts0slpL8iGIAAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

