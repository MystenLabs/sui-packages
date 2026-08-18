module 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781 {
    struct Ha4cb5 has store, key {
        id: 0x2::object::UID,
        he7763: 0x2::object::ID,
        h09588: address,
        h562d2: 0x1::option::Option<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>,
        h1495e: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun h28fc0(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Ha4cb5, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.h09588 == 0x2::tx_context::sender(arg3), 401);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg2) {
            let v1 = arg2 * 120 / 100 - v0;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.h1495e) >= v1, 404);
            0x2::coin::join<0x2::sui::SUI>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.h1495e, v1), arg3));
        };
    }

    public fun h2ddbd(arg0: &mut Ha4cb5, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>) {
        hcf37f(arg0, arg1);
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&arg2) == arg0.he7763, 405);
        assert!(0x1::option::is_none<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&arg0.h562d2), 403);
        0x1::option::fill<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&mut arg0.h562d2, arg2);
    }

    public fun h3b99f(arg0: &mut Ha4cb5, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        hcf37f(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.h1495e) >= arg2, 404);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.h1495e, arg2), arg3)
    }

    public fun h3f331(arg0: &mut Ha4cb5, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.h1495e, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun h46580(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : address {
        let v0 = Ha4cb5{
            id     : 0x2::object::new(arg2),
            he7763 : arg0,
            h09588 : arg1,
            h562d2 : 0x1::option::none<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(),
            h1495e : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Ha4cb5>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun h4e71a(arg0: &Ha4cb5, arg1: &0x2::tx_context::TxContext) : &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        assert!(arg0.h09588 == 0x2::tx_context::sender(arg1), 401);
        assert!(0x1::option::is_some<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&arg0.h562d2), 402);
        0x1::option::borrow<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&arg0.h562d2)
    }

    public fun h7ee41(arg0: &mut Ha4cb5, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: address) {
        hcf37f(arg0, arg1);
        arg0.h09588 = arg2;
    }

    public fun h87f5b(arg0: &Ha4cb5) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.h1495e)
    }

    public fun hb2696(arg0: &mut Ha4cb5, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        hcf37f(arg0, arg1);
        assert!(0x1::option::is_some<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&arg0.h562d2), 402);
        0x1::option::extract<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&mut arg0.h562d2)
    }

    fun hcf37f(arg0: &Ha4cb5, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1) == arg0.he7763, 405);
    }

    // decompiled from Move bytecode v7
}

