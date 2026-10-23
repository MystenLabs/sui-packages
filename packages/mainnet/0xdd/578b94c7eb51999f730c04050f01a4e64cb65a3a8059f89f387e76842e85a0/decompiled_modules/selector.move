module 0xdd578b94c7eb51999f730c04050f01a4e64cb65a3a8059f89f387e76842e85a0::selector {
    public fun new() : vector<bool> {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::selector::new()
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::selector::take_first(arg0, arg1)
    }

    public fun chosen_amount(arg0: &vector<u128>, arg1: &vector<bool>) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::selector::chosen<u128>(arg0, arg1)
    }

    public fun chosen_results(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>, arg1: &vector<bool>) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::selector::chosen<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

