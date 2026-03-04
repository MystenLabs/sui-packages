module 0xc15b7347940746d5df150fb11689c61d3d698710f3bea719dd97a6f6ef771255::rcusd {
    struct RCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1056 || 0x2::tx_context::epoch(arg1) == 1057, 0);
        let (v1, v2) = 0x2::coin::create_currency<RCUSD>(arg0, 9, b"ANT", b"RCUSD", x"e69cbae69e84e7baa72052574120e58d8fe8aeae2052323520e6ada3e5bc8fe5b086e78eb0e5ae9ee4b896e7958ce8b584e4baa7e5bc95e585a52053756920e7bd91e7bb9cefbc8ce68ea8e587ba207263555344efbc88e794b12052574120e694afe68c81e79a84e4bba3e5b881efbc89e58f8ae585b6e58fafe7949fe681afe78988e69cac20726355534470e38082e6ada4e6aca1e59088e4bd9ce8aea9e58f97e588b0e79b91e7aea1e79a84e993bee4b88be98791e89e8de5b7a5e585b7e59ca82053756920e4b88ae993beefbc8ce5ae9ee78eb0e993bee4b88ae58c96e380820a7263555344efbc9ae4b880e7a78de794b12052574120e694afe69291e79a84e4bba3e5b881e28094e28094e794b1e58f97e79b91e7aea1e38081e58fafe7949fe681afe79a84e78eb0e5ae9ee98791e89e8de5b7a5e585b7e694afe68c81efbc8ce9949ae5ae9a203120e7be8ee58583e4bbb7e580bcefbc9b0a726355534470efbc9ae68c81e69c89e4babae8b4a8e68abc20726355534420e5908ee88eb7e5be97e79a84e694b6e79b8ae587ade8af81e4bba3e5b881efbc8ce585b7e69c89e7949fe681afe883bde58a9be38082e585b6e694b6e79b8ae69da5e6ba90e58c85e68bacefbc9ae5ba95e5b1822052574120e8b584e4baa7e7bb84e59088efbc88e5a682e4bba3e5b881e58c96e8b4a7e5b881e5b882e59cbae59fbae98791efbc89e38081e585ace993bee6bf80e58ab1efbc8ce8aea9e68c81e69c89e4babae883bde5a49fe68c81e7bbade88eb7e5be97e8b4a8e68abce59b9ee68aa5e380820a726355534420e4b88e2072635553447020e5b086e4b88e2053756920e4b88ae79a84e59084e7b1bb204465466920e58d8fe8aeaee99b86e68890efbc8ce5b8a6e69da5e696b0e79a84e993bee4b88ae694b6e79b8ae69cbae4bc9ae38081e5809fe8b4b7e58a9fe883bde3808152574120e694afe68c81e79a84e8b584e4baa7e6b581e58aa8e680a7efbc8ce5b086e8bf9be4b880e6ada5e689a9e5a4a7e79baee5898de5b7b2e8b685e8bf8720323020e4babfe7be8ee585832054564c20e79a8420537569204465466920e7949fe68081e38082e6ada4e59088e4bd9ce4bba3e8a1a8e79d80e5b086e59088e8a784e993bee4b88be8b584e4baa7e4b88ae993bee79a84e9878de8a681e8bf9be5b195efbc8ce8808c2072635553447020e4b99fe698afe9a696e689b9e794b1e69cbae69e84e7baa7e4bf9de99a9ce4b88ee79c9fe5ae9ee694b6e79b8ae8b584e4baa7e694afe68c81e79a84e7949fe681afe4bba3e5b881e38082e5afb92053756920e8808ce8a880efbc8ce8bf99e4b99fe698afe9a9b1e58aa82054564c20e5a29ee995bfe4b88ee5bc95e585a5e99d9ee58aa0e5af86e58e9fe7949fe6b581e58aa8e680a7e79a84e585b3e994aee9878ce7a88be7a291e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmeeiJUan1ABNZQWdBnijeRKSbnAFK1PRy9BXYeXdUjUi9"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<RCUSD>(&mut v3, 18400000000000000000, @0x63d4139ae649198e4ff4b48ac936419d47c71ce2816073a33f6a1badfb4a4b58, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCUSD>>(v3, @0x63d4139ae649198e4ff4b48ac936419d47c71ce2816073a33f6a1badfb4a4b58);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RCUSD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

