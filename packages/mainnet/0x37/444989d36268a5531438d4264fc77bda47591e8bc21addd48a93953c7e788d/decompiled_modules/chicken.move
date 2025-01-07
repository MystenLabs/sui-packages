module 0x37444989d36268a5531438d4264fc77bda47591e8bc21addd48a93953c7e788d::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 9, b"CHICKEN", b"Chicken SUI", b"Chicken SUI #memecoin #cryptocurrency #memes #bitcoin #crypto #dogecoin #instagram #twitter #btc #ethereum #memesdaily #elonmusk #pakistan #memecontest #lahore #tweetchat #eidcollection #tweetme #post #daily #pakistani #facebookchallenge #laugh #eidmubarak #cryptonews #lahoreqalandars #eiduladha #nalaiq #altcoin #cryptotrading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHICKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

