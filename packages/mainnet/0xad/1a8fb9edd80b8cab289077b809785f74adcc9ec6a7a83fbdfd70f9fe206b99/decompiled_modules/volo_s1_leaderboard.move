module 0xad1a8fb9edd80b8cab289077b809785f74adcc9ec6a7a83fbdfd70f9fe206b99::volo_s1_leaderboard {
    struct Volo_S1_Leaderboard has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        urls: vector<vector<u8>>,
    }

    public fun transfer(arg0: Volo_S1_Leaderboard, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Volo_S1_Leaderboard>(arg0, arg1);
    }

    public fun url(arg0: &Volo_S1_Leaderboard) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: Volo_S1_Leaderboard, arg1: &mut 0x2::tx_context::TxContext) {
        let Volo_S1_Leaderboard {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Volo_S1_Leaderboard) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/wx1fhq2vbs27te7fnwuu-VggQr6OfkaXlPRxV4eEe2HsFnDi3rY");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/v9itk4r6ehrw16yl8haf-oSp2xe0MT2OUOeDTdUor6DOZLp2KNc");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/cmlb8i7ouo0j4my24353-e1H4MNpxeJI9ysLLtSM46RoCugj8cP");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/sl9jo71ck1e5pbwm04i2-haHQB1V0Qing8Iv0TrwfJzI5X5hrkJ");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/m1ftqzgir3wt4wpmjgtn-GyoyN1A15TjBT1fiA8rmjj4t3Hh8n1");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/b2n1di8ogxe50zstorde-Mm8WwedhlklKNv4UhOF8exKSvYNjBR");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/badp0lvca3ljpv6bblr7-Pg4sVlBgvrl3CiVRxf5ulZlrJIBICM");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/i0q5a5um59uvgf2j0ub2-edPQMA1M5NO4vUappuxyIbGT4ql82k");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/vcmjw15xhczft6jet2yh-V1FQhP8ggGDM8xhudYhPXHswu1Yxpx");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-09-01/p7jshfqx5fxkgmnzisxp-WoN04VdSCWuieA7gMbRlEs45MfuGP6");
        let v1 = MinterCap{
            id   : 0x2::object::new(arg0),
            urls : v0,
        };
        let v2 = 1;
        while (v2 <= 10) {
            let v3 = 0x2::tx_context::sender(arg0);
            mint(&v1, v3, v2, arg0);
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<MinterCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &MinterCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10, 0);
        assert!(arg2 > 0, 0);
        let v0 = Volo_S1_Leaderboard{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Volo S1 Leaderboard"),
            description : 0x1::string::utf8(b"Volo S1 Leaderboard Ranking"),
            url         : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg0.urls, arg2 - 1)),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Volo_S1_Leaderboard>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<Volo_S1_Leaderboard>(v0, arg1);
    }

    public fun name(arg0: &Volo_S1_Leaderboard) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

