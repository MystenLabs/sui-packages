module 0xea2bba4dfb844485a7e8b5db214b2c3c06ac5dcbd1b97061424f60536c738119::tmpsui {
    struct TMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMPSUI>(arg0, 6, b"TMPSUI", b"TRMPSUI", b"Trump sui Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.decentralized-content.com/-/rs:fit:1920:1920/aHR0cHM6Ly9tYWdpYy5kZWNlbnRyYWxpemVkLWNvbnRlbnQuY29tL2lwZnMvYmFmeWJlaWEzdDVtZXJqZWltaGRtcHFteHo2N2FqdWh4eTRyNzNjNnFidmNxNjU0MmNucW5qNXZrNnU")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<TMPSUI>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<TMPSUI>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

