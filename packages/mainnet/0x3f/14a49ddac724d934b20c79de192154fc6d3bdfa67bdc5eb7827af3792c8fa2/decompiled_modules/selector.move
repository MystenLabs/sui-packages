module 0x3f14a49ddac724d934b20c79de192154fc6d3bdfa67bdc5eb7827af3792c8fa2::selector {
    public fun chosen_amount(arg0: &vector<u128>, arg1: &vector<bool>) : u128 {
        0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::selector::chosen<u128>(arg0, arg1)
    }

    public fun chosen_results(arg0: &vector<0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::optimizer::OptimizeResult>, arg1: &vector<bool>) : 0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::optimizer::OptimizeResult {
        0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::selector::chosen<0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::optimizer::OptimizeResult>(arg0, arg1)
    }

    public fun new() : vector<bool> {
        0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::selector::new()
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        0xe055cb342cbdf3fe4f4bf0b608a75173be465ca75358e075fdb0b9a041ccb1d4::selector::take_first(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

