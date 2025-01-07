module 0x65c5109b437a52292349605e134f8b09ba36a90fd0c9165fbbc08598bc5fa2a5::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"LEN", b"satoshi revealed", b"---BEGIN TRIBUTE--- #./BitLen ::::::::::::::::::: :::::::.::.::.:.::: :.: :.' ' ' ' ' : : :.:'' ,,xiW,\"4x, '' : ,dWWWXXXXi,4WX, ' dWWWXXX7\" `X, lWWWXX7 __ _ X :WWWXX7 ,xXX7' \"^^X lWWWX7, _.+,, _.+., :WWW7,. `^\"-\" ,^-' WW\",X: X, \"7^^Xl. _(_x7' l ( :X: __ _ `. \" XX ,xxWWWWX7 )X- \"\" 4X\" .___. ,W X :Xi _,,_ WW X 4XiyXWWXd \"\" ,, 4XWWWWXX , R7X, \"^447^ R, \"4RXk, _, , TWk \"4RXXi, X',x lTWk, \"4RRR7' 4 XH :lWWWk, ^\" `4 ::TTXWWi,_ Xll :.. =-=-=-=-=-=-=-=-=-= LEN \"rabbi\" SASSAMA 1980-2011 Len was our friend. A brilliant mind, a kind soul, and a devious schemer; husband to Meredith brother to Calvin, son to Jim and Dana Hartshorn, coauthor and cofounder and Shmoo and so much more. We dedicate this silly hack to Len, who would have found it absolutely hilarious. --Dan Kaminsky, Travis Goodspeed P.S. My apologies, BitCoin people. He also would have LOL'd at BitCoin's new dependency upon ASCII BERNANKE :'::.:::::.:::.::.: : :.: ' ' ' ' : :': :.: _.__ '.: : _,^\" \"^x, : ' x7' `4, XX7 4XX XX XX Xl ,xxx, ,xxx,XX ( ' _,+o, | ,o+,\" 4 \"-^' X \"^-'\" 7 l, ( )) ,X :Xx,_ ,xXXXxx,_,XX 4XXiX'-___-`XXXX' 4XXi,_ _iXX7' , `4XXXXXXXXX^ _, Xx, \"\"^^^XX7,xX W,\"4WWx,_ _,XxWWX7' Xwi, \"4WW7\"\"4WW7',W TXXWw, ^7 Xk 47 ,WH :TXXXWw,_ \"), ,wWT: ::TTXXWWW lXl WWT: ----END TRIBUTE----", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_12_16_26_f445e2aeee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

