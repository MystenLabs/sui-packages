module 0x9fb815709b27c46199295dac6fe1942a566ad189f3f9736f596f78c7f8118a3a::random_nft {
    struct RANDOM_NFT has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        fee_recipient: address,
        fixed_fee_mist: u64,
        symbol: vector<u8>,
    }

    struct Cards has key {
        id: 0x2::object::UID,
        keys: vector<vector<u8>>,
        names: vector<vector<u8>>,
        uris: vector<vector<u8>>,
        image_urls: vector<vector<u8>>,
        weights: vector<u16>,
        total_weight: u32,
    }

    struct CardNft has store, key {
        id: 0x2::object::UID,
        key: 0x1::string::String,
        name: 0x1::string::String,
        uri: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        website: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct CardMintedEvent has copy, drop {
        index: u16,
        key: vector<u8>,
        name: vector<u8>,
        uri: vector<u8>,
        image_url: vector<u8>,
        nft_id: 0x2::object::ID,
        owner: address,
    }

    fun build_description_string(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"World Icons Cards - ");
        0x1::string::append_utf8(&mut v0, copy_vector_u8(arg0));
        v0
    }

    fun concat_ids(arg0: &0x2::object::ID, arg1: &0x2::object::ID) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(arg1));
        v0
    }

    fun copy_vector_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: RANDOM_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Abraham_Lincoln");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Abraham Lincoln");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://dugwxhp3ckcoiebgbxcvwkdo3ebwc77mm64in4u4yhzhtpqapooa.arweave.net/HQ1rnfsShOQQJg3FWyhu2QNhf-xnuIbynMHyeb4Ae5w");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://rxbe4gt6sduqltisj5cvnoyusby3kwpqjpnqcctkrmqb6ajayf4q.arweave.net/jcJOGn6Q6QXNEk9FVrsUkHG1WfBL2wEKaosgHwEgwXk");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Abraham_Lincoln_Holo");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Abraham Lincoln Holographic");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://qexhls3ulrjmzpb5f6priereqh3xlzhuwz7xwgklopihg5gwqsya.arweave.net/gS51y3RcUsy8PS-fFBIkgfd15PS2f3sZS3PQc3TWhLA");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://vpf4jui42yw2iinchukk563ehk7w2muhe5vtheozgb7u4wn3sdxq.arweave.net/q8vE0RzWLaQhoj0UrvtkOr9tMocnazOR2TB_Tlm7kO8");
        0x1::vector::push_back<u16>(&mut v4, 270);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"S_Bankman_Fried");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Sam Bankman-Fried");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://vljciwzvbaqwl3dc546axbs2zsxoikqscwxiqk5rofp3n2ugvwsa.arweave.net/qtIkWzUIIWXsYu88C4ZazK7kKhIVrogrsXFftuqGraQ");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://zwgy3fw4cjbciydjzjktpg4czund4uly74tnoboeph352pcamapq.arweave.net/zY2NltwSQiRgacpVN5uCzRo-UXj_JtcFxHn33TxAYB8");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Will_Smith");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Will Smith");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://rzf7e7zaf7tzevn7v6njzc6fjomgsdzbmurxtdz3uwf5gfah4yuq.arweave.net/jkvyfyAv55JVv6-anIvFS5hpDyFlI3mPO6WL0xQH5ik");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://gryi6p2urlpixeksvldzpukqoid32fzhjzznflmdl3gfdkcjkagq.arweave.net/NHCPP1SK3ouRUqrHl9FQcge9FydOctKtg17MUahJUA0");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Logan_Paul");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Logan Paul");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://vsulrpjy72dkhlembeg2wcy7mayzmh2qa7szbiuu3ywkahsprrxq.arweave.net/rKi4vTj-hqOsjAkNqwsfYDGWH1AH5ZCilN4soB5PjG8");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://527dutaecpx2pm7xflfgxfqtobox4xb6vmfbnsithgobyh4yhqya.arweave.net/7r46TAQT76ez9yrKa5YTcF1-XD6rChbJEzmcHB-YPDA");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Leonardo_DiCaprio");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Leonardo Dicaprio");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://kot6ajbztnjh6vaprmqwln4tpuiybdcshd3jjku26sfe3ykxsiwa.arweave.net/U6fgJDmbUn9UD4shZbeTfRGAjFI49pSqmvSKTeFXkiw");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://r7fwvsggjnr55moxvtnb7h3uan5vspjtfwqmft727l55k3cwfuea.arweave.net/j8tqyMZLY96x16zaH590A3tZPTMtoMLP-vr71WxWLQg");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Johnny_Depp");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Johnny Depp");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://66oly3ghie5nl5ifel4irgqb34bx2axb6ah3u7egbu7cnklufdaa.arweave.net/95y8bMdBOtX1BSL4iJoB3wN9AuHwD7p8hg0-Jql0KMA");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://z2jveob6umna3v7dryitx2objpvwpmvfzhaqbqxl665j5vrcpw3q.arweave.net/zpNSOD6jGg3X444RO-nBS-tnsqXJwQDC6_e6ntYifbc");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Venus_Williams");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Venus Williams");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://76k7v72spxvn2od6ikqtjvmgj3y4mkwyxqfoez7yvh37kzyimr3a.arweave.net/_5X6_1J96t04fkKhNNWGTvHGKti8CuJn-Kn39WcIZHY");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://yyuerr5rdzgwehao4yyplfpbbcgagr42n7k763yxkyoux6yqrroq.arweave.net/xihIx7EeTWIcDuYw9ZXhCIwDR5pv1f9vF1YdS_sQjF0");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Thomas_Edison");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Thomas Edison");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://bahlsgdogzgh2erfindlezrehxlm2ua7gtuotmv6qjclgfvdxfoa.arweave.net/CA65GG42TH0SJUNGsmYkPdbNUB806OmyvoJEsxajuVw");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://a5ltxahofv4rurxvbtpmklfpl4uihvztlh6mb65c3uwdriqlttra.arweave.net/B1c7gO4teRpG9QzexSyvXyiD1zNZ_MD7ot0sOKILnOI");
        0x1::vector::push_back<u16>(&mut v4, 637);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Morgan_Freeman");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Morgan Freeman");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://7goy7kaqrriez5uectocgu6om4exwwikvnjlhs36qjlgasqmby2a.arweave.net/-Z2PqBCMUEz2hBTcI1POZwl7WQqrUrPLfoJWYEoMDjQ");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://zkcz4b5okbjqxlti533qvjpzulrp4t732aekojyvulmwtfoxxtfa.arweave.net/yoWeB65QUwuuaO73CqX5ouL-T_vQCKcnFaLZaZXXvMo");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Mark_Zuckerberg");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Mark Zuckerberg");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://rjpxxwm4anrdzuxnoimpxkr5n3e4fxdmfsdrwee34duvqg74yvwq.arweave.net/il972ZwDYjzS7XIY-6o9bsnC3GwshxsQm-DpWBv8xW0");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://bndpjkcl62gzcjmj3rkvtsud6min7y4cerx2vjhzwxvwnee3qjea.arweave.net/C0b0qEv2jZElidxVWcqD8xDf44Ikb6qk-bXrZpCbgkg");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Mark_Zuckerberg_Holo");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Mark Zuckerberg Holographic");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://5eucr5akqvogh6gum7ijk5sjle54ldyjjl5hqyt3e2iur7u2td6a.arweave.net/6Sgo9AqFXGP41GfQlXZJWTvFjwlK-nhieyaRSP6amPw");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://hq2ao476akw2see22m6h4zooxcc7jv6spu7knxiqecb5j63jjkaa.arweave.net/PDQHc_4CrakQmtM8fmXOuIX019J9PqbdECCD1PtpSoA");
        0x1::vector::push_back<u16>(&mut v4, 139);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Jack_Dorsey");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Jack Dorsey");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://wuzoc5keoxqfyf7irsrvmqlrruywphqxq7weswmlvgbi3nd6n6dq.arweave.net/tTLhdUR14FwX6IyjVkFxjTFnnheH7ElZi6mCjbR-b4c");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://4v66izj7rkqqffndovzoqfmgj52cha7sulgfyqtc4jwh7al2ry4a.arweave.net/5X3kZT-KoQKVo3Vy6BWGT3Qjg_KizFxCYuJsf4F6jjg");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"R_Oppen_heimer");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Robert Oppenheimer");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://wr4femrawrxi6whecpovbui3dkttpt3d2ivu6lslh2fshrlpgwea.arweave.net/tHhSMiC0bo9Y5BPdUNEbGqc3z2PSK08uSz6LI8VvNYg");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://73kmucnyxialgtwwbewb2lu2rwate7t3enq5j4lu7k3yo5pzr2ka.arweave.net/_tTKCbi6ALNO1gksHS6ajYEyfnsjYdTxdPq3h3X5jpQ");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Steve_Harvey");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Steve Harvey");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://dnparwz4wtvnnsn3w67zdbovyhrpjsds6tukddtnxoashegwykrq.arweave.net/G14I2zy06tbJu7e_kYXVweL0yHL06KGObbuBI5DWwqM");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://t2gkdfta3ezos2wsieme36mfsn27iqkeszjzwcn7zm6xgsufld2q.arweave.net/noyhlmDZMulq0kEYTfmFk3X0QUSWU5sJv8s9c0qFWPU");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Tiger_Woods");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Tiger Woods");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://n5k3odkg47ozbo5p6czsqjugko4vbqq26xpcjgbumzkldl4fqesa.arweave.net/b1W3DUbn3ZC7r_CzKCaGU7lQwhr13iSYNGZUsa-FgSQ");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://opi4ysd6bfweaxge7cyaayuj632lbok4qlyq44sh4h7dkptxc2la.arweave.net/c9HMSH4JbEBcxPiwAGKJ9vSwuVyC8Q5yR-H-NT53FpY");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Simone_Biles");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Simone Biles");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://tlhrt556nkbgj4dgkca7o5qgkae6fsjpxpdqhigya46lmserljqa.arweave.net/ms8Z975qgmTwZlCB93YGUAniyS-7xwOg2Ac8tkiRWmA");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://x23w7m24wdfem6mbm4xgck5qjjqqyquzkkdsmirqs5cssxsz5fua.arweave.net/vrdvs1ywykZ5gWcuYSuwSmEMQplShyYiMJdFKV5Z6Wg");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Tony_Hawk");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Tony Hawk");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://345ts2azli7dejs4rlssljlx7g4mg2w5p4nvvvyki6ij5pqzxata.arweave.net/3zs5aBlaPjImXIrlJaV3-bjDat1_G1rXCkeQnr4ZuCY");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://sevmbg56rel7vpilk5xcxyvmfluyob6nj3sdoui4v56fnuqefzoa.arweave.net/kSrAm76JF_q9C1duK-KsKumHB81O5DdRHK98VtIELlw");
        0x1::vector::push_back<u16>(&mut v4, 333);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Bill_Gates");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Bill Gates");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://ncozcxbvkiw4rsl6qjjte3ojrcssf4cnlcwyep7myngjuriyh43a.arweave.net/aJ2RXDVSLcjJfoJTMm3JiKUi8E1YrYI_7MNMmkUYPzY");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://6lfhaboadldsvigohbc5rruwc3thppa2rpm65wf4x3vqwedd3lda.arweave.net/8spwBcAaxyqgzjhF2MaWFuZ3vBqL2e7YvL7rCxBj2sY");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Muhammad_Ali");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Muhammad Ali");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://gudoiw3oai56fvwlvnmt2j34dz2ni62qy77csebr6hkd7cifwf6a.arweave.net/NQbkW24CO-LWy6tZPSd8HnTUe1DH_ikQMfHUP4kFsXw");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://bcfcjmlfxwkgrcnolfjektwqqwso6336srdtwuoygaoe3qx3nk7q.arweave.net/CIoksWW9lGiJrllSRU7QhaTvb36URztR2DAcTcL7ar8");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Barrack_Obama");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Barrack Obama");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://r4xnvehsxfxmqjutruu4hp62keg36tnifiplzcymtmmg7qcvyqwa.arweave.net/jy7akPK5bsgmk40pw7_aUQ2_TagqHryLDJsYb8BVxCw");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://wqr3glwfmdfrli2azvhvloew3brdgozsjg5kpkcoohupc5hqnkha.arweave.net/tCOzLsVgyxWjQM1PVbiW2GIzOzJJuqeoTnHo8XTwao4");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"M_Luther_King_Jr");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"M. Luther King Jr.");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://kfupzow2moewni7bvi7zfigw3n3qdovtsmkrnjhwynbhlko5xzqq.arweave.net/UWj8utpjiWaj4ao_kqDW23cBurOTFRak9sNCdandvmE");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://e2ewnd2fz2o7l3f7pv4ytd65v46wlasq5ynnc2fozeiolruufgya.arweave.net/Jolmj0XOnfXsv315iY_drz1lglDuGtForskQ5caUKbA");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"M_Luther_King_Jr_Holo");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"M. Luther King Jr. Holographic");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://wrwf5b7g5lgmu5g3kah6moscdqwnb74oq5zs72ei3mt66sbhgqta.arweave.net/tGxeh-bqzMp021AP5jpCHCzQ_46Hcy_oiNsn70gnNCY");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://tapgnlf2dkfpwjlgfeeyeoupdpw6it6uk7h7c2kaiesj6t3xadiq.arweave.net/mB5mrLoaivslZikJgjqPG-3kT9RXz_FpQEEkn093ANE");
        0x1::vector::push_back<u16>(&mut v4, 107);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Oprah_Winfrey");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Oprah Winfrey");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://4lg3nnq5kgjlcwunt3wbc5syovzuqojxjfzpfg5kymugkhpnljeq.arweave.net/4s22th1RkrFajZ7sEXZYdXNIOTdJcvKbqsMoZR3tWkk");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://3gxtksmseeb3rozp5bkevglqp2y52z7o6lbhortne7w5csxs3liq.arweave.net/2a81SZIhA7i7L-hUSplwfrHdZ-7ywndGbSft0Ury2tE");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Michael_Jordan");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Michael Jordan");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://4gfhi75ytgxkt7zexmobr53grjark3u3m4irky5f56jwgevghunq.arweave.net/4Yp0f7iZrqn_JLscGPdmikEVbptnERVjpe-TYxKmPRs");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://casmu2krmerlwhivypwdfi7fee6wvwfn2xww7v3kahzjc2gmffda.arweave.net/ECTKaVFhIrsdFcPsMqPlIT1q2K3V7W_XagHykWjMKUY");
        0x1::vector::push_back<u16>(&mut v4, 214);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Jennifer_Lawrence");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Jennifer Lawrence");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://dvrkx2vx45g7iin2kft3aqazsplq2mtsjm5adwnik5vjpvvcu55q.arweave.net/HWKr6rfnTfQhulFnsEAZk9cNMnJLOgHZqFdql9aip3s");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://ekyr5ruvhpzzpaict7z43jpuxli76gok263lklnjcyg7xeyud3ta.arweave.net/IrEexpU785eBAp_zzaX0utH_GcrXtrUtqRYN-5MUHuY");
        0x1::vector::push_back<u16>(&mut v4, 81);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Jennifer_Lawrence_Holo");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Jennifer Lawrence Holographic");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://aj3ah44fvdghapmez3cwkrfzss2sfy4ruhge7clexiohquilmi2a.arweave.net/AnYD84WozHA9hM7FZUS5lLUi45GhzE-JZLoceFELYjQ");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://id3eyj43cgcv2kt7zf4hge75ajvxolqicdyroghbflxcid6qls6a.arweave.net/QPZMJ5sRhV0qf8l4cxP9Amt3LggQ8RcY4SruJA_QXLw");
        0x1::vector::push_back<u16>(&mut v4, 40);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Kobe_Bryant");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Kobe Bryant");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://ghhc2mcygxgw2ekxk6xyqwhc2nyo3bi7sn4la5eu6kr4m63krlsq.arweave.net/Mc4tMFg1zW0RV1eviFji03DthR-TeLB0lPKjxntqiuU");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://zk6yciannjfthctktyrjdvqkf4x3ks5pojaexziwhapd6zy6bsja.arweave.net/yr2BIA1qSzOKap4ikdYKLy-1S69yQEvlFjgeP2ceDJI");
        0x1::vector::push_back<u16>(&mut v4, 81);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Donald_Trump");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Donald Trump");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://ih6o6ppotuvuz4m4qeujqx4vuzsybnvfmanhayg3gba6er5urxaq.arweave.net/QfzvPe6dK0zxnIEomF-VpmWAtqVgGnBg2zBB4ke0jcE");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://epshrcdv2ld5ocjaj2c6fbbxd2a7qpqj7feyleze6azgeauegucq.arweave.net/I-R4iHXSx9cJIE6F4oQ3HoH4Pgn5SYWTJPAyYgKENQU");
        0x1::vector::push_back<u16>(&mut v4, 81);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Michael_Saylor");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Michael Saylor");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://6qfrwe3glyzegyfmbdwfqcuscbp7by43uerycplkfopbi6r7nc2q.arweave.net/9AsbE2ZeMkNgrAjsWAqSEF_w45uhI4E9aiueFHo_aLU");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://ayo7k3fbcsx3opi3no6rqxiwhalgofhziaewjtvovxnqvovfilbq.arweave.net/Bh31bKEUr7c9G2u9GF0WOBZnFPlACWTOrq3bCrqlQsM");
        0x1::vector::push_back<u16>(&mut v4, 81);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Robert_Downey_Jr");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Robert Downey Jr");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://gbbshlxj5eh3wsvvtrwa25ytrtat42ko4upbhc4jhf36becgvvhq.arweave.net/MEMjrunpD7tKtZxsDXcTjME-aU7lHhOLiTl34JBGrU8");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://juacpxciqdj42skn3z6enz7xbztqgh3pqdfjjqlktmb5qpbe34ya.arweave.net/TQAn3EiA081JTd58Ruf3DmcDH2-AypTBapsD2Dwk3zA");
        0x1::vector::push_back<u16>(&mut v4, 35);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Elon_Musk");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Elon Musk");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://5m5aojyc3yta2uqgpdoljismiww7ldfmvrfvg4es7kpuxvpyairq.arweave.net/6zoHJwLeJg1SBnjctKJMRa31jKysS1NwkvqfS9X4AiM");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://35fkmwemrq4qudly2t7jdd2lpeks5x2czu5vkzut4ghbylf5555q.arweave.net/30qmWIyMOQoNeNT-kY9LeRUu30LNO1Vmk-GOHCy973s");
        0x1::vector::push_back<u16>(&mut v4, 35);
        0x1::vector::push_back<vector<u8>>(&mut v0, b"SATOSHI_NAKAMOTO");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Satoshi Nakamoto");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://5nxvpobme6odwvo3iyjaavcnveum3bu6scmwmc6kmyex42iky7ia.arweave.net/629XuCwnnDtV20YSAFRNqSjNhp6QmWYLymYJfmkKx9A");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"https://d4g7hjcv7urtcfizdl7x4zkunkbw27agulrykodhqww6gtp3c5jq.arweave.net/Hw3zpFX9IzEVGRr_fmVUaoNtfAai44U4Z4Wt4037F1M");
        0x1::vector::push_back<u16>(&mut v4, 5);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u16>(&v4)) {
            v5 = v5 + (*0x1::vector::borrow<u16>(&v4, v6) as u32);
            v6 = v6 + 1;
        };
        let v7 = Cards{
            id           : 0x2::object::new(arg1),
            keys         : v0,
            names        : v1,
            uris         : v2,
            image_urls   : v3,
            weights      : v4,
            total_weight : v5,
        };
        0x2::transfer::share_object<Cards>(v7);
        let v8 = Config{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            fee_recipient  : @0x4fcb22683d2e5274253bf02a858fb8bd36072a02e92fa6106ccc6ad125f05aa9,
            fixed_fee_mist : 1000000000,
            symbol         : b"WIC",
        };
        0x2::transfer::share_object<Config>(v8);
        let v9 = 0x2::package::claim<RANDOM_NFT>(arg0, arg1);
        let v10 = 0x2::display::new<CardNft>(&v9, arg1);
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{website}"));
        0x2::display::add<CardNft>(&mut v10, 0x1::string::utf8(b"symbol"), 0x1::string::utf8(b"{symbol}"));
        0x2::display::update_version<CardNft>(&mut v10);
        0x2::transfer::public_share_object<0x2::display::Display<CardNft>>(v10);
        0x2::package::burn_publisher(v9);
    }

    public entry fun mint_random_nft(arg0: &Cards, arg1: &Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.fixed_fee_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3), arg1.fee_recipient);
        let v1 = prng_u64(arg0, arg3);
        assert!(arg0.total_weight > 0, 0);
        let v2 = weighted_pick(arg0, v1);
        let v3 = (v2 as u64);
        let v4 = 0x1::vector::borrow<vector<u8>>(&arg0.keys, v3);
        let v5 = 0x1::vector::borrow<vector<u8>>(&arg0.names, v3);
        let v6 = 0x1::vector::borrow<vector<u8>>(&arg0.uris, v3);
        let v7 = 0x1::vector::borrow<vector<u8>>(&arg0.image_urls, v3);
        let v8 = CardNft{
            id          : 0x2::object::new(arg3),
            key         : 0x1::string::utf8(copy_vector_u8(v4)),
            name        : 0x1::string::utf8(copy_vector_u8(v5)),
            uri         : 0x1::string::utf8(copy_vector_u8(v6)),
            image_url   : 0x1::string::utf8(copy_vector_u8(v7)),
            url         : 0x1::string::utf8(copy_vector_u8(v7)),
            website     : 0x1::string::utf8(b"https://world-icons-cards.com"),
            description : build_description_string(v5),
            symbol      : 0x1::string::utf8(copy_vector_u8(&arg1.symbol)),
        };
        let v9 = CardMintedEvent{
            index     : v2,
            key       : copy_vector_u8(v4),
            name      : copy_vector_u8(v5),
            uri       : copy_vector_u8(v6),
            image_url : copy_vector_u8(v7),
            nft_id    : 0x2::object::uid_to_inner(&v8.id),
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CardMintedEvent>(v9);
        0x2::transfer::public_transfer<CardNft>(v8, 0x2::tx_context::sender(arg3));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    fun prng_u64(arg0: &Cards, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::id<Cards>(arg0);
        let v3 = 0x1::hash::sha3_256(concat_ids(&v2, &v1));
        0x2::object::delete(v0);
        (*0x1::vector::borrow<u8>(&v3, 0) as u64) | (*0x1::vector::borrow<u8>(&v3, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&v3, 2) as u64) << 16 | (*0x1::vector::borrow<u8>(&v3, 3) as u64) << 24 | (*0x1::vector::borrow<u8>(&v3, 4) as u64) << 32 | (*0x1::vector::borrow<u8>(&v3, 5) as u64) << 40 | (*0x1::vector::borrow<u8>(&v3, 6) as u64) << 48 | (*0x1::vector::borrow<u8>(&v3, 7) as u64) << 56
    }

    public entry fun set_cards(arg0: &mut Cards, arg1: &Config, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<u16>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.owner, 0);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 0);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 0);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 0);
        assert!(v0 == 0x1::vector::length<u16>(&arg6), 0);
        assert!(v0 > 0, 0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + (*0x1::vector::borrow<u16>(&arg6, v1) as u32);
            v1 = v1 + 1;
        };
        assert!(v2 > 0, 0);
        arg0.keys = arg2;
        arg0.names = arg3;
        arg0.uris = arg4;
        arg0.image_urls = arg5;
        arg0.weights = arg6;
        arg0.total_weight = v2;
    }

    public entry fun set_config(arg0: &mut Config, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        arg0.fee_recipient = arg1;
        arg0.fixed_fee_mist = arg2;
        arg0.symbol = arg3;
    }

    fun weighted_pick(arg0: &Cards, arg1: u64) : u16 {
        let v0 = arg1 % (arg0.total_weight as u64);
        let v1 = 0x1::vector::length<u16>(&arg0.weights);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = (*0x1::vector::borrow<u16>(&arg0.weights, v2) as u64);
            if (v0 < v3) {
                return (v2 as u16)
            };
            v0 = v0 - v3;
            v2 = v2 + 1;
        };
        ((v1 - 1) as u16)
    }

    // decompiled from Move bytecode v6
}

