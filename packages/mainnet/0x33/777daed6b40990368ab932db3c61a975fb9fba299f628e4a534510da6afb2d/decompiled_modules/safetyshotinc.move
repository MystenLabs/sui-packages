module 0x33777daed6b40990368ab932db3c61a975fb9fba299f628e4a534510da6afb2d::safetyshotinc {
    struct SAFETYSHOTINC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFETYSHOTINC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFETYSHOTINC>(arg0, 9, b"SHOT", b"Safety Shot INC", b"msg @testing7878 for access to deployer | Website: https://www.streetinsider.com/Globe+Newswire/Safety+Shot+Announces+Strategic+Alliance+with+Bonk+Founding+Contributors%2C+Initiating+BONK+Treasury+Strategy/25178272.html | Twitter: https://x.com/b412414/status/1954884997497930120 | Created on: bundle-bonk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://45.77.98.90:8080/ipfs/QmdZAPbiTEUkaG8VUXLphNtn3WkJhfCeoCnmXffzSECRDk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFETYSHOTINC>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFETYSHOTINC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFETYSHOTINC>>(v1);
    }

    // decompiled from Move bytecode v6
}

