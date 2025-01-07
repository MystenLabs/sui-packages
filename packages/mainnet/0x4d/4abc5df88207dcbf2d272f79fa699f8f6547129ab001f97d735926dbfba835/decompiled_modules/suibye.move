module 0x4d4abc5df88207dcbf2d272f79fa699f8f6547129ab001f97d735926dbfba835::suibye {
    struct SUIBYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBYE>(arg0, 9, b"SUIBYE", b"SUI YOU LATER", b"SUI YOU LATER GUY'S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://amber-managerial-guanaco-417.mypinata.cloud/files/bafkreihr5prsft6xxadimvs6xk6max6pjdxfewtcyhi4osegvoqggf56li?X-Algorithm=PINATA1&X-Date=1734286063&X-Expires=30&X-Method=GET&X-Signature=a03077adb4aea708192c39ce45789dc70406ad62cadbcf1f990d0cb7e50a82d3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBYE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBYE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

