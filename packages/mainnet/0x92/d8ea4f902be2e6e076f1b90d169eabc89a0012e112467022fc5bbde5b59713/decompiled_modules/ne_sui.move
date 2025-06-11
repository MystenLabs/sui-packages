module 0x92d8ea4f902be2e6e076f1b90d169eabc89a0012e112467022fc5bbde5b59713::ne_sui {
    struct NE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NE_SUI>(arg0, 9, b"neSUI", b"netest Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sVd3id1WUDggRAUAAHAaAJ0BKoAAgAA+bTSXSKQipS4jErp5wA2JYgZwDRbExp3mOu69WPKK9Lza4C35g8hjsFfz/0G/tR67vpY/+m+V8/D7PS/z3xWTcq973tWIrhgdyVeomi2mCC/c/ySdNKMZoCplGEuQlsou61S5tOc5aqtK42OXjc0GWrNQ99mhv2sr//TgVgz9UTiMPFTyAF3BJUYfxnS0eobLXQtuXnoKf9/HKpfgFWWI9nRzmUB/8zMEW+H1c4YqaflQ8kDLjOcAjmA5//V4xiYteuLevc+AOVo/+6TBpkeS0gAA/v1uSAAAtSAvEm5YUJl8HirG6UNXkoev05+57Pt3/HqaH2BNe1UbzvQJq9d7reG8OJxjNsUwFyUUYK50QyiFViON+DE7YAHk06FRsz2FAkdmbXpb1sEbs0+Y1bbhjSrHJ9TPaiE596t7XDq67Kbe3qDuKZ5Z2NjDbxQyjeUDm3XIA//P+9cX9z/T3RMjyGytwQFFDbNIpZ5rAvf0kz24ps9nnMhYPFM/6+uGr2srROLC6XsHrLFCGhlQBIxRLKrVhJigmOiLWt/yL33MSCVKi8ziLqehEvqVLMKR7ZDKbINmFDEMaiVoDDvQjQK1jy4GA0lGIwGAgOsL+fOFqvY+mkWTnCwsdXxuIv1VQD8m1eYE0yUzhMp4rQy+cUebzyyKRC0k2tpAeLPR3+oochKHJXQgTH9Z+UEuK8KKYZ9Pys34d4r7x8Vycfh+SYbac+XGKTS3hzMDjUYnGYvzwcWTRFze2HILtw5BbAeLa+L05b1I72ypjeGn4iX3caEarEbWBRQLiveRkAFJGwORXHLgyJSADq9ec8BlZruUV6cOA+BxkCuncZcDTGY3ZQJur5xJksFa1LwIkdn5UooBRMhjTMSP3mc5KXmxJx19b6AsBzAbw6N0fV84JrNTmd4sOUxD8YidDoxmOm3FX5EKG6O81kQcf0Bzhh5/ytM9CQysJniD/wjxPS/jl6Of+qbhF6O3TD50c4jo2vl8Tccn95zS16t9nGen2rusYC3uhj00knR9SBUU6R+Tdv0Jv8tilTlE84PkRPAGicZVGtZa2Ws4/4WpN7G4chX2hCEKZ1e2/2GviLcHzO2BScSHmZwbPJXYPh0GTt5ymNFZejzjP1em+M/qlxac5MnVn03fod6f28ve+QIDINKGokAfN5k3lVCYFrGSegZWllRSe0UsIHnW/+yJCuKFmqzTe4+xlu1a5VY12/WSEBErt9YFBHP4eoFZd9Rml6VKYDavz3ElpcoHsq9AWg7ijffkRvtM0JcKx903ckZXxPOFNKv/0Tiewh+IORLdL++ukr6icpVhUABl16jBiBJ7nicUIvavoggcQMcmv+6zIvEe7o2ksfu7waxi3aUDqovMjwjMUr2+ge7aZy2smcd5upls7izPSAH40DW/+IFLaMTeGyVhbyID7CNr04uqkICS4sxGlY0tcBl8M0+rOLlNjqZ6x9+NTGFbH1y9pBiyfq5K7kr/wpMa5tWg+6khSKjvQTdyQvFBrwYOZi3ZBN9Q1+IWAal2oSmPhpmdEsasQFmG0T7a1OxLomUk780ax+Ow5LvpqeQQ2PHSqaFfRjhM7IkDwfQ/kKS3ssLAXak152rODlZmQ0prUuytnkoQ9MZK2Bh/t0eXDrukLZlLSf/xuFhk3+aerZogX6HwjKgAbj4RlfsrttbjSRESwzK7WdVxbg619EOKEsEDKOAa0OF0Bh8S4FvaQawza02t74tOKNcioBaphiFRa/PPH5GArFppzgT+oeWPq+JY6wAAAAAAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

