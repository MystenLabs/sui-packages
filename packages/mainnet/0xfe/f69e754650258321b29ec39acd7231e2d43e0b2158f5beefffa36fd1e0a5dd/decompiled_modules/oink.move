module 0xfef69e754650258321b29ec39acd7231e2d43e0b2158f5beefffa36fd1e0a5dd::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<OINK>(arg0, 6, b"OINK", b"SuiOink", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtIEAABXRUJQVlA4IMYEAACwHACdASqAAIAAPm0ylUekIqIhKBILKIANiWMA1x4TD321wwdUB7C9ur5gP2U3wD+wdSdz7Xsh/uj6N2qoJp8K5k+nwH5Afljz27Vv963uTi/CT3HP+J5EGMn0VNDX1b7B/6s/7ovVm0Sj3xHurlTpNfzcmvL31jhJGVXC4JgMYwRXlAbGFVZp+oHfkeGs+L9UVHyG1aT6+jan+BIgh5yeiY+6FPLf6fwbb3Sf7yL/C5SYlk/mFppUV934n9Dh5tKUTehD7uxkuGQm5Vz7j4tMHvflgqRBgUWbbRPt7MXhRzasyo6L+5bVapEM5glAAP78+EADv9jbV5YyMJqQxuLCUfvipXClGCgDWFiI8nlBaM0n6ZisvMjh9UmwMs+1UzbaXc8r+nBGQPQmlBQ8xv2e/Us4V2APglP9pqsDoTc831kaSFzq0ONd38DiqJ67RBG/DGc4wB4C0LQy/2WWjqCBOt01VzQDh0CNTg3T65JA2bj9Gw8erj8T3o+sjjcdrY4dUFLsbH0EKgvFq7OR/7pi0M/aCD6he6bct1PN8lQLXC1GdQM6Wr2qfcnI+EmgpbHO8z37cwh2KPmIvhDVIL6Gldx1n6eQhjYn76YzRokre7fP1BCoAAl/rNkv6tmi3LrA0MDsu+3ge7AYO5zT88/PBNZLSUv0qg8/dUywdMF0V+xmXn7fK1lvyLQDhiXotnG9NlQA7pjFj01j12ft6fT42AO/834kbWQCpDeSmQYXhfucTV8uGZUmWzanI2A8D/5BTkt1933/hMFVdug/XA2TbgVJ/4gUBf7ONGdMwfgQSBji7reBpt3jNSuy20sFAiD8yuprtTpmAO6aVShv00VyKP3EOplOQ4nJpI5uu/It3tRllUVTepfApcIPB59KMLaGQQPZj1WHezw1iTn9K2z1mAt5pGDsMCy2WU9qZw4uwJO/dkk6y4gOS8f0vuwzWgR4F8Qdlf0t/deExcE78yIJ/L57aSTIP53GE3JyPDPp3iVZH/4Na0paEoFu/soKqf/Po0x59SFtf+JGwSUp98TsDl89hRm9gazh4xfnpPQ7HHKfRaWDN36wvQWZU/BxXMDiPOh9LvG3gFNPP6WN8l22huqmdsJZ/hbPngj4PoL9P/hbduzEr6VMOymUDarMvjX5M5dUJjmbJ2jZ1kBsP1Qn5fwlUb+SRL3jFIyq6iHPDVcEqzfCgf44o/00FpIcbXJZeDxNBTgQvnNqSTFb21oZawyh47yAvLno1YlSFTP2v086YiK7TPunK/eRkGk3rNRt45f33kM3LxodZw0VOZWQOk4yp4e6IjzU3s/ZFV+kvyD1GN3vaXXxucf7z2gN+x6iq2yFC3JZktn3quf16CuNNMVZAvxKylD5CLi6GHVwRdBRa/3uRjUUpeHeSBGqsHMQrP8SzVTFL9mGRfsRRW0T7kFQbOjz1BVP787fxdZtqv5WKWJ9jzOBo+9e92DQ9Xrk2XpdmG455TJf9K1i1hMDfrMhf5PUafzijGP/1P1iTU/xQi9rzZfOC8y3SNThsN6NIB6/j5A94SHYNlXbh3gxjleV/PfDN40vPW0fBUSKv9/5q/gQ7oBMmT6OHK/7c/gQ7oaN/dEPe/W0EEQB0gghmhEQAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

