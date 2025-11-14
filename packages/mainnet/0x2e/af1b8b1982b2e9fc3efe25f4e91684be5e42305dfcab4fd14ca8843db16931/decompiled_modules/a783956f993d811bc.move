module 0x2eaf1b8b1982b2e9fc3efe25f4e91684be5e42305dfcab4fd14ca8843db16931::a783956f993d811bc {
    struct A38f12468332ef716 has store {
        a2d5cf79ee424b824: bool,
        afaa9c0637bf609fe: u64,
        aa5c536d0bc3827ff: u64,
        ae50da578c0f38435: u64,
        ac342a6a5cd6c420e: u64,
    }

    struct A0ea878587b719a64 has store, key {
        id: 0x2::object::UID,
        a1cf5727aac3dee05: address,
        a08c9d43f296691a1: u64,
        a028c32870d59a6e8: u64,
        ad66eeaefed209b0f: u64,
        aaa372af3148e91d6: u64,
        aa97ca27b48d72d63: u64,
        ab4cce892f91e179d: u64,
        a9eb34d40c591e724: u64,
        ab38de150e2840b48: u64,
        a7cea368357b7d971: bool,
        a7f1f6920b2de2e7c: bool,
        a31f95bf83694efb8: u64,
        a3a9b9d10c7fad14a: u64,
        a95922dffece9e7da: u64,
        ad4b2d799016f877d: u64,
        aa2dd106d27c96b47: u64,
        a25cd0a9a0177bf90: u64,
        a0c40826cc82d548a: u64,
        aabf49d2de82cae44: bool,
        af5b451c97d6b5192: u64,
        a82053465eda9bdc4: u64,
        ac342a6a5cd6c420e: u64,
        a2059360c1827f292: u64,
        aa8d95a01d0a32dc8: u64,
        ab3241576c7b31a2f: u64,
        a56fd38bb12b204a1: u64,
        ad2616e93a0796e5b: u64,
        a92e57031b4ab16ae: A38f12468332ef716,
        a24721a1521e81292: u64,
    }

    public fun a028c32870d59a6e8(arg0: &A0ea878587b719a64) : u64 {
        arg0.a028c32870d59a6e8
    }

    public fun a05a599e2994b5326(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a31f95bf83694efb8 = arg1;
    }

    public fun a082bc5b19227e420(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.afaa9c0637bf609fe
    }

    public fun a08c9d43f296691a1(arg0: &A0ea878587b719a64) : u64 {
        arg0.a08c9d43f296691a1
    }

    public fun a0b76acee4e57496d(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aaa372af3148e91d6 = arg1;
    }

    public fun a0c40826cc82d548a(arg0: &A0ea878587b719a64) : u64 {
        arg0.a0c40826cc82d548a
    }

    public fun a0ff07c53a8744191(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a08c9d43f296691a1 = arg1;
    }

    public fun a1530e2bdfbfc62a8(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad4b2d799016f877d = arg1;
    }

    public fun a1d4036cdf86e784c(arg0: &A0ea878587b719a64, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.a1cf5727aac3dee05 == 0x2::tx_context::sender(arg1), 13906834732689129471);
    }

    public fun a1d6a6de3412f4387(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a2d5cf79ee424b824 = arg1;
    }

    public fun a2059360c1827f292(arg0: &A0ea878587b719a64) : u64 {
        arg0.a2059360c1827f292
    }

    public fun a218b36ceb9152448(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a3a9b9d10c7fad14a = arg1;
    }

    public fun a24721a1521e81292(arg0: &A0ea878587b719a64) : u64 {
        arg0.a24721a1521e81292
    }

    public fun a25cd0a9a0177bf90(arg0: &A0ea878587b719a64) : u64 {
        arg0.a25cd0a9a0177bf90
    }

    public fun a31f95bf83694efb8(arg0: &A0ea878587b719a64) : u64 {
        arg0.a31f95bf83694efb8
    }

    public fun a32961c499210d617(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab38de150e2840b48 = arg1;
    }

    public fun a34e369572ad2a090(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a95922dffece9e7da = arg1;
    }

    public fun a3710772f3b618373(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ae50da578c0f38435
    }

    public fun a3a9b9d10c7fad14a(arg0: &A0ea878587b719a64) : u64 {
        arg0.a3a9b9d10c7fad14a
    }

    public fun a3ecf09b0d024e1dc(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad2616e93a0796e5b = arg1;
    }

    public fun a442a391e32abfc25(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab4cce892f91e179d = arg1;
    }

    public fun a4c5eb3dce9c64948(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ac342a6a5cd6c420e = arg1;
    }

    public fun a534253be9d7387c0(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad66eeaefed209b0f = arg1;
    }

    public fun a56fd38bb12b204a1(arg0: &A0ea878587b719a64) : u64 {
        arg0.a56fd38bb12b204a1
    }

    public fun a58f3a8d8a4c01c05(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a7f1f6920b2de2e7c = arg1;
    }

    public fun a5ada7d72000d7a1d(arg0: &mut A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg5);
        arg0.a7cea368357b7d971 = arg3;
        if (!arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg4, arg5);
        };
    }

    public fun a6219201efde0d46a(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a028c32870d59a6e8 = arg1;
    }

    public fun a63fd163584228a06(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa8d95a01d0a32dc8 = arg1;
    }

    public fun a6608954bf63e2c55(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a24721a1521e81292 = arg1;
    }

    public fun a7cea368357b7d971(arg0: &A0ea878587b719a64) : bool {
        arg0.a7cea368357b7d971
    }

    public fun a7e35067d3a47eeae(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.aa5c536d0bc3827ff
    }

    public fun a7f1f6920b2de2e7c(arg0: &A0ea878587b719a64) : bool {
        arg0.a7f1f6920b2de2e7c
    }

    public fun a82053465eda9bdc4(arg0: &A0ea878587b719a64) : u64 {
        arg0.a82053465eda9bdc4
    }

    public fun a8ca7876854a16d35(arg0: &mut 0x2::tx_context::TxContext) : A0ea878587b719a64 {
        let v0 = 1000000000;
        let v1 = A38f12468332ef716{
            a2d5cf79ee424b824 : false,
            afaa9c0637bf609fe : 1000,
            aa5c536d0bc3827ff : 100 * 1000000000,
            ae50da578c0f38435 : 500 * 1000000000,
            ac342a6a5cd6c420e : 1,
        };
        A0ea878587b719a64{
            id                : 0x2::object::new(arg0),
            a1cf5727aac3dee05 : 0x2::tx_context::sender(arg0),
            a08c9d43f296691a1 : 500,
            a028c32870d59a6e8 : 1000,
            ad66eeaefed209b0f : 15000,
            aaa372af3148e91d6 : 60000,
            aa97ca27b48d72d63 : 1000 * v0,
            ab4cce892f91e179d : 500 * v0,
            a9eb34d40c591e724 : 10000 * v0,
            ab38de150e2840b48 : 2000 * v0,
            a7cea368357b7d971 : true,
            a7f1f6920b2de2e7c : true,
            a31f95bf83694efb8 : 2000,
            a3a9b9d10c7fad14a : 10000,
            a95922dffece9e7da : 5,
            ad4b2d799016f877d : v0,
            aa2dd106d27c96b47 : 100000 * 1000000,
            a25cd0a9a0177bf90 : 380 * v0,
            a0c40826cc82d548a : 500 * v0,
            aabf49d2de82cae44 : true,
            af5b451c97d6b5192 : 180 * 10000,
            a82053465eda9bdc4 : 390 * 10000,
            ac342a6a5cd6c420e : 1,
            a2059360c1827f292 : 500 * 1000000,
            aa8d95a01d0a32dc8 : 500 * v0,
            ab3241576c7b31a2f : 1000000000 / 4,
            a56fd38bb12b204a1 : 1000000000 / 2,
            ad2616e93a0796e5b : 10 * v0,
            a92e57031b4ab16ae : v1,
            a24721a1521e81292 : 500,
        }
    }

    public fun a95922dffece9e7da(arg0: &A0ea878587b719a64) : u64 {
        arg0.a95922dffece9e7da
    }

    public fun a9d6ab431aeba9963(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a0c40826cc82d548a = arg1;
    }

    public fun a9eb34d40c591e724(arg0: &A0ea878587b719a64) : u64 {
        arg0.a9eb34d40c591e724
    }

    public fun aa2b7c8f205e1d355(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ac342a6a5cd6c420e = arg1;
    }

    public fun aa2dd106d27c96b47(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa2dd106d27c96b47
    }

    public fun aa324ade7b3d5401f(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a25cd0a9a0177bf90 = arg1;
    }

    public fun aa4c6cb5de6de44f7(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aabf49d2de82cae44 = arg1;
    }

    public fun aa614ca3191892ed6(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a9eb34d40c591e724 = arg1;
    }

    public fun aa8d95a01d0a32dc8(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa8d95a01d0a32dc8
    }

    public fun aa97ca27b48d72d63(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa97ca27b48d72d63
    }

    public fun aaa372af3148e91d6(arg0: &A0ea878587b719a64) : u64 {
        arg0.aaa372af3148e91d6
    }

    public fun aabf49d2de82cae44(arg0: &A0ea878587b719a64) : bool {
        arg0.aabf49d2de82cae44
    }

    public fun aac907976125d91ba(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa2dd106d27c96b47 = arg1;
    }

    public fun aaf28676a30aaeb45(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.aa5c536d0bc3827ff = arg1;
    }

    public fun ab3241576c7b31a2f(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab3241576c7b31a2f
    }

    public fun ab38de150e2840b48(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab38de150e2840b48
    }

    public fun ab4cce892f91e179d(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab4cce892f91e179d
    }

    public fun abc3ae4f61d07f772(arg0: &mut 0x2::tx_context::TxContext) : A0ea878587b719a64 {
        let v0 = a8ca7876854a16d35(arg0);
        v0.a25cd0a9a0177bf90 = 1 * 1000000000;
        v0.a0c40826cc82d548a = 0 * 1000000000;
        v0.a2059360c1827f292 = 10 * 1000000;
        v0.aa8d95a01d0a32dc8 = 10 * 1000000000;
        v0.aa97ca27b48d72d63 = 1 * 1000000000;
        v0.ab4cce892f91e179d = 1 * 1000000000;
        v0.a9eb34d40c591e724 = 1 * 1000000000;
        v0.ab38de150e2840b48 = 1 * 1000000000;
        v0.a92e57031b4ab16ae.aa5c536d0bc3827ff = 2 * 1000000000;
        v0.a92e57031b4ab16ae.ae50da578c0f38435 = 1 * 1000000000;
        v0
    }

    public fun ac342a6a5cd6c420e(arg0: &A0ea878587b719a64) : u64 {
        arg0.ac342a6a5cd6c420e
    }

    public fun ac6050178924956f0(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a56fd38bb12b204a1 = arg1;
    }

    public fun ad0be49e9ae36ae12(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ae50da578c0f38435 = arg1;
    }

    public fun ad139106ca7775201(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.afaa9c0637bf609fe = arg1;
    }

    public fun ad2616e93a0796e5b(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad2616e93a0796e5b
    }

    public fun ad4b2d799016f877d(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad4b2d799016f877d
    }

    public fun ad66eeaefed209b0f(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad66eeaefed209b0f
    }

    public fun ada14a7c9727063c9(arg0: &A0ea878587b719a64) : bool {
        arg0.a92e57031b4ab16ae.a2d5cf79ee424b824
    }

    public fun adac8080ae87e9ba7(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab3241576c7b31a2f = arg1;
    }

    public fun ae63c22553f1e03a6(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a82053465eda9bdc4 = arg1;
    }

    public fun ae939843e6bfc4243(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a2059360c1827f292 = arg1;
    }

    public fun ae9a4ee60c1c9da40(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ac342a6a5cd6c420e
    }

    public fun aede7ad9675ac505d(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.af5b451c97d6b5192 = arg1;
    }

    public fun af5b451c97d6b5192(arg0: &A0ea878587b719a64) : u64 {
        arg0.af5b451c97d6b5192
    }

    public fun aff8e537b8d0b8029(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa97ca27b48d72d63 = arg1;
    }

    // decompiled from Move bytecode v6
}

