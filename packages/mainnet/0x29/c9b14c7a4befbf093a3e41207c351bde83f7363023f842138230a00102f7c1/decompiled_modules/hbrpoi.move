module 0x29c9b14c7a4befbf093a3e41207c351bde83f7363023f842138230a00102f7c1::hbrpoi {
    struct DRV has drop {
        q: bool,
    }

    struct CLB has key {
        id: 0x2::object::UID,
        a9m: 0x2::balance::Balance<0x2::sui::SUI>,
        u80: u64,
    }

    struct A has drop {
        iak: 0x2::object::ID,
        nvr: u64,
    }

    struct G has store, key {
        id: 0x2::object::UID,
        o: 0x2::object::ID,
    }

    public fun fllgv(arg0: &A) : u64 {
        arg0.nvr
    }

    public entry fun gykd(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = CLB{
            id  : v0,
            a9m : 0x2::balance::zero<0x2::sui::SUI>(),
            u80 : 1,
        };
        0x2::transfer::share_object<CLB>(v1);
        let v2 = G{
            id : 0x2::object::new(arg0),
            o  : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<G>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun mdl(arg0: &mut CLB, arg1: &G, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::object::borrow_id<CLB>(arg0) == &arg1.o, 4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.a9m, arg2);
    }

    public fun micgs() {
        abort 9
    }

    public fun mio(arg0: &mut CLB, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: A, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(0x2::object::id<CLB>(arg0) == arg2.iak, 3);
        assert!(v0 >= arg2.nvr, 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.a9m, arg1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.a9m, v0 - arg2.nvr, arg3)
    }

    public fun miuwrh() : u64 {
        42
    }

    public fun rdmcrj(arg0: &A) : 0x2::object::ID {
        arg0.iak
    }

    public fun rxhf(arg0: &mut CLB, arg1: &G, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::borrow_id<CLB>(arg0) == &arg1.o, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.a9m) >= arg2, 5);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.a9m, arg2, arg3)
    }

    public fun sgwcb(arg0: &mut CLB, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, A) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.a9m) >= arg1, 1);
        let v0 = A{
            iak : 0x2::object::id<CLB>(arg0),
            nvr : arg1 + arg1 * arg0.u80 / 1000000,
        };
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.a9m, arg1, arg2), v0)
    }

    public fun tizbx(arg0: &CLB) : u64 {
        arg0.u80
    }

    public fun wvuct(arg0: &mut CLB, arg1: &G, arg2: u64) {
        assert!(0x2::object::borrow_id<CLB>(arg0) == &arg1.o, 4);
        arg0.u80 = arg2;
    }

    public fun yjch(arg0: &CLB) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.a9m)
    }

    public fun yybhb() : DRV {
        DRV{q: false}
    }

    // decompiled from Move bytecode v6
}

