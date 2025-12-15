module 0xdca00286c7f9ced028f3366b0cbd82e2176f0f66694004fcb015930f3f9de71::b_sui {
    struct B_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUI>(arg0, 9, b"bSUI", b"BEE Staked SUI", b"By staking your SUI with BeeStake, you receive bsSUI But that's just the start: every transaction fuels real-world impact by directing protocol fees straight to local small bee farms across the USA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRhQEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBoAAAABDzD/ERHCTNs2+cqf4ZgYxaSI/kcdAKt/D1ZQOCDUAwAAMBUAnQEqgACAAD5tMpRIpCKhoSSRyzCADYljBnANONDO6RUomznsG9Ke3g57f0S86r7FfoAdLkbRWkgme+Rxgm6wAGieWuUWGjOSfMnDGHLuXwrBGp8GlI08MEtKijpaU6tAvXQXsAzVUrogfTcN5JXtRLRgTVMSipELaGqkJelUZwcnbPaEKJiHN0KhilhtCFG/UX/2JMYznFzgaUuBEYQgEJ4aWZp7Gfbnm2fCxrYtSAD+/PiOeCzZ3LJq1n/7mfwUdcU9/3r6lx+/3U+xNHb1iE0mtUIOhLPS0DtrfbfU4P5/4OJKbAj4OJJZXEy57zTnb7/ssAoTu2JUUa9h7e3nm1xKv6krMVIbXZmIxxsPrBUdE+TUBRdxvZ/bHsVQd/mipMfc3decDdsCAEW3yTCImdl5V8V5Ejc1LWFg12uF9y8quXm8nX2SOLvnWroY6qVCCjKnFFru2l5oz58WypFkhNQEynnMER6JdAuXAlAyAY4NJHdT61nZzFaOZPH2vOyb1KjlRD3tL7UZz6X9gLeoEF5WWLEet0eQwdyddZfnBuUFIwGezRCGap0SMDXvKVSw1+N5/P3m3nbSYzikIlhEimoQP3K+EJWTqfnObi3yxh93/9cuXaOXAbEaYqzXZ5FnK5EY5XwrUIoSXe4dWTiKOJMHhFq/T5O3418BOuGeiQRAwxQjllNblISkM5of3wiNgubQbypiVJW7bYj4s9HsQ5kH5lK9B6AJH50Mtrb9TKcc3YwfrCZpNgEcHdaD+wmb+esYswSVQ8AEVt8creWpO1JzMdn9I1Q01yLY7gTvm4ockYVmTmoUHeGzCADIIkr1bvtPClTIbRGpbyXlN8ZIhXtEwh277YMyMiZVD9kO4Aws2JyD0F1cZqBe+dU67kYGQqPobzc1htQ8WPoFGy/j5Qt7wI398jS1srjNzg716TP2FO8DzPszEKrXg5lcVXA3qH2EL66ZL8DwyHfJXrCZ3P40aR6hnHuthuWfZLaf9P5MdC3vcMC+kpYBjiueVY+TZ3U28cEy/uQQU6RHGBw683A8U4V8Koy86AMo+SLGgibxuKLIFOIyNkH9JoeDvMfoecpjsVXkoVUzXBUGLUBPmPIZnBLHHdr3wCQU4w1jJjS7H9aYscPa1Ra4HT3oYJqum7puZK8e0W8DRerhkwwIDrFmNri6Zo8reOpIR5G8NHH3aU1ET79p/uc7herMU4HHazeZgf37cAMyJHJlIt8Z/GKiPn1FjovmO2RpkpOYnbAOwZzcoVDJq+8lkBHgfTXdQKeq0tNThQ9cEHenUwAAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

