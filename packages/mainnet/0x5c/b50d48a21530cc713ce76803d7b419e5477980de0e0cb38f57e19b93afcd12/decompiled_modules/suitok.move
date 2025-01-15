module 0x5cb50d48a21530cc713ce76803d7b419e5477980de0e0cb38f57e19b93afcd12::suitok {
    struct SUITOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOK>(arg0, 9, b"SUITOK", b"SUITOK", b"SUITOK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/images/search?view=detailV2&ccid=I5NuzgzH&id=4CF46ABB39B81C172F548BE5A652B34660F46623&thid=OIP.I5NuzgzHLLp8Hat4-O4VRgHaEK&mediaurl=https%3a%2f%2fwww.bleepstatic.com%2fcontent%2fhl-images%2f2022%2f08%2f31%2fTikTok.jpg&exph=900&expw=1600&q=cute+token+logo&simid=607998517747529230&FORM=IRPRST&ck=EAB6C06A37F3447DF02DEA5E22BE3194&selectedIndex=83&itb=0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITOK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

